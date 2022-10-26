//
//  ContentType.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import Foundation

/// A `Content-Type` header field of an HTTP request.
public struct ContentType: HTTPHeaderField {
    
    public static let name = "Content-Type"
    
    public var value: String {
        mediaType._text
    }
    
    /// The media type (MIME type) of the content type.
    ///
    /// This property is used for the ``value``.
    public var mediaType: MediaType
    
    public var parameters: [HTTPHeaderParameter]
    
    /// Creates a new ``ContentType`` object.
    /// - Parameters:
    ///   - mediaType: The media type (MIME type) of the content type.
    ///   - parameters: The additional parameters of the header field.
    public init(mediaType: MediaType, parameters: [HTTPHeaderParameter] = []) {
        self.mediaType = mediaType
        self.parameters = parameters
    }
}


// MARK: - Helpers

extension ContentType {
    
    internal init(boundary: Boundary) {
        self.mediaType = .multipartFormData
        self.parameters = [HTTPHeaderParameter("boundary", value: boundary._value)]
    }
}
