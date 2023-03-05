//
//  Subpart.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import Foundation

/// A subpart of the ``MultipartFormData``'s body.
///
/// This can either be initialized the standard way or via the result builder initializer.
public struct Subpart: Hashable {
    
    /// The content disposition of the subpart.
    public var contentDisposition: ContentDisposition
    
    /// The optional content type of the subpart.
    public var contentType: ContentType?
    
    /// The body of the subpart.
    ///
    /// This is plain data.
    public var body: Data
    
    /// Creates a new ``Subpart`` object manually.
    ///
    /// There is also ``init(header:body:)`` which is more convenient to use.
    ///
    /// - Parameters:
    ///   - contentDisposition: The content disposition of the subpart.
    ///   - contentType: The optional content type of the subpart.
    ///   - body: The body of the subpart.
    public init(contentDisposition: ContentDisposition, contentType: ContentType? = nil, body: Data) {
        // swiftlint:disable:previous function_default_parameter_at_end
        self.contentDisposition = contentDisposition
        self.contentType = contentType
        self.body = body
    }
}

// MARK: - Result Builders

extension Subpart {
    /// Creates a new ``Subpart`` object with result builders.
    ///
    /// The header builder must contain a ``ContentDisposition``, the ``ContentType`` is optional.
    /// The order of those two header fields does not matter.
    ///
    /// The body builder contains the data.
    /// It can be a single data instance but also accepts multiple (they will be combined to a single one).
    ///
    /// ```swift
    /// Subpart {
    ///     ContentDisposition(name: "id")
    ///     ContentType(mediaType: .textPlain)
    /// } body: {
    ///     Data("1234".utf8)
    ///     Data("abcd".utf8)
    /// }
    /// ```
    ///
    /// - Throws: Can only throw an error if one of the result builders can throw one.
    ///
    /// - Parameters:
    ///   - header: The result builder for the header.
    ///   - body: The result builder for the body.
    public init(
        @HTTPHeaderBuilder header: () throws -> HTTPHeaderBuilder.BuildResult,
        @BodyDataBuilder body: () throws -> Data
    ) rethrows {
        let headerFields = try header()
        self.contentDisposition = headerFields._contentDisposition
        self.contentType = headerFields._contentType
        self.body = try body()
    }
}

// MARK: - Debug

extension Subpart: CustomDebugStringConvertible {
    public var debugDescription: String {
        return String(decoding: _data, as: UTF8.self)
    }
}

// MARK: - Helpers

extension Subpart {
    internal var _data: Data {
        let contentTypeData: Data = contentType.map { $0._data + ._crlf } ?? Data()
        return contentDisposition._data + ._crlf + contentTypeData + ._crlf + body
    }
}
