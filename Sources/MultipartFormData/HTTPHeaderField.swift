//
//  HTTPHeaderField.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import Foundation

/// A header field of an HTTP request.
public protocol HTTPHeaderField: Sendable, Hashable, CustomDebugStringConvertible {
    
    /// The name of the header field.
    ///
    /// This value is case-insensitive.
    static var name: String { get }
    
    /// The value of the header field.
    ///
    /// Whitespace before the value is ignored.
    var value: String { get }
    
    /// The additional parameters of the header field.
    var parameters: [HTTPHeaderParameter] { get set }
}

// MARK: - Debug

extension HTTPHeaderField {
    /// A textual representation of this instance, suitable for debugging.
    public var debugDescription: String {
        return rawValue
    }
}

// MARK: - Helpers

extension HTTPHeaderField {
    /// The actual header field value resulting from ``value`` and ``parameters``.
    public var parameterizedValue: String {
        if parameters.isEmpty { return value }
        return "\(value); \(parameters.rawValue)"
    }
    
    /// The raw string representation of a header field.
    public var rawValue: String {
        return "\(Self.name): \(parameterizedValue)"
    }
    
    /// The data representation of a header field.
    public var data: Data {
        return Data(rawValue.utf8)
    }
}
