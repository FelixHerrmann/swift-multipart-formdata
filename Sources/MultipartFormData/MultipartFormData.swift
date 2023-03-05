//
//  MultipartFormData.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import Foundation

/// Generates multipart/form-data for an HTTP request.
///
/// Multipart form data is an encoding format devised as a means of encoding an HTTP form for posting up to a server.
/// For more informations and a detailed description see [RFC7578](https://datatracker.ietf.org/doc/html/rfc7578).
///
/// There are two ways to create a ``MultipartFormData``:
/// - manually with ``init(boundary:body:)``
/// - via result builder with ``init(boundary:builder:)``
///
/// The ``boundary`` can be created manually but using a randomly generated one is fine in most situations.
///
/// To create a request from ``MultipartFormData`` use ``httpBody`` and configure the `Content-Type` header
/// field appropriately. There is a dedicated `URLRequest` initializer that handles this configuration.
///
/// - Note: The ``debugDescription`` is overloaded and will print the form-data request in a human readable format.
///
/// ```swift
/// let boundary = try Boundary(uncheckedBoundary: "example-boundary")
/// let multipartFormData = try MultipartFormData(boundary: boundary) {
///     Subpart {
///         ContentDisposition(name: "field1")
///     } body: {
///         Data("value1".utf8)
///     }
///     try Subpart {
///         ContentDisposition(name: "field2")
///         ContentType(mediaType: .applicationJson)
///     } body: {
///         try JSONSerialization.data(withJSONObject: ["string": "abcd", "int": 1234], options: .prettyPrinted)
///     }
///
///     let filename = "test.png"
///     let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
///     let fileDirectory = homeDirectory.appendingPathComponent("Desktop").appendingPathComponent(filename)
///
///     if FileManager.default.fileExists(atPath: fileDirectory.path) {
///         try Subpart {
///             try ContentDisposition(uncheckedName: "field3", uncheckedFilename: filename)
///             ContentType(mediaType: .applicationOctetStream)
///         } body: {
///             try Data(contentsOf: fileDirectory)
///         }
///     }
/// }
///
/// let url = URL(string: "https://example.com/example")!
/// let request = URLRequest(url: url, multipartFormData: multipartFormData)
/// let (data, response) = try await URLSession.shared.data(for: request)
/// ```
///
/// ```http
/// POST https://example.com/example HTTP/1.1
/// Content-Length: 428
/// Content-Type: multipart/form-data; boundary="example-boundary"
///
/// --example-boundary
/// Content-Disposition: form-data; name="field1"
///
/// value1
/// --example-boundary
/// Content-Disposition: form-data; name="field2"
/// Content-Type: application/json
///
/// {
///   "string" : "abcd",
///   "int" : 1234
/// }
/// --example-boundary
/// Content-Disposition: form-data; name="field3"; filename="test.png"
/// Content-Type: application/octet-stream
///
/// <<png-data>>
/// --example-boundary--
/// ```
public struct MultipartFormData: Hashable {
    
    /// The boundary to separate the subparts of the ``body`` with.
    public let boundary: Boundary
    
    /// The content type for the request header field.
    ///
    /// Do not modify the `mediaType` and the boundary element of the `parameters`.
    public var contentType: ContentType
    
    /// The body represented by subparts.
    public var body: [Subpart]
    
    /// Creates a new ``MultipartFormData`` object manually.
    ///
    /// There is also ``init(boundary:builder:)`` which is more convenient to use.
    ///
    /// - Parameters:
    ///   - boundary: The boundary for the multipart/form-data. By default it generates a random one.
    ///   - body: The body based on ``Subpart`` elements. By default it is empty.
    public init(boundary: Boundary = .random(), body: [Subpart] = []) {
        self.contentType = ContentType(boundary: boundary)
        self.body = body
        self.boundary = boundary
    }
}

// MARK: - HTTP Request

extension MultipartFormData {
    /// The generated body data for the HTTP request.
    ///
    /// This combines all the data from the subparts into one big data object.
    public var httpBody: Data {
        let bodyData: Data = body
            .map { ._dash + boundary._asciiData + ._crlf + $0._data + ._crlf }
            .reduce(Data(), +)
        return bodyData + ._dash + boundary._asciiData + ._dash + ._crlf
    }
}

// MARK: - Result Builders

extension MultipartFormData {
    /// Creates a new ``MultipartFormData`` object with a result builder.
    ///
    /// The builder consists of a single or multiple ``Subpart``s.
    /// For more information how to build a ``Subpart`` check  it's documentation.
    ///
    /// ```swift
    /// try MultipartFormData {
    ///     Subpart {
    ///         ContentDisposition(name: "field1")
    ///     } body: {
    ///         Data("value1".utf8)
    ///     }
    ///     try Subpart {
    ///         ContentDisposition(name: "field2")
    ///         ContentType(mediaType: .applicationJson)
    ///     } body: {
    ///         try JSONSerialization.data(withJSONObject: ["key": "value"])
    ///     }
    /// }
    /// ```
    ///
    /// - Throws: Can only throw an error if the result builder can throw one.
    ///
    /// - Parameters:
    ///   - boundary: The boundary for the multipart/form-data. By default it generates a random one.
    ///   - builder: The result builder for the subparts.
    public init(boundary: Boundary = .random(), @MultipartFormDataBuilder builder: () throws -> [Subpart]) rethrows {
        self.contentType = ContentType(boundary: boundary)
        self.body = try builder()
        self.boundary = boundary
    }
}

// MARK: - Debug

extension MultipartFormData: CustomDebugStringConvertible {
    public var debugDescription: String {
        return String(decoding: contentType._data + ._crlf + ._crlf + httpBody, as: UTF8.self)
    }
}
