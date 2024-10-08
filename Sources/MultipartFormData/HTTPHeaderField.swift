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
        return _text
    }
}

// MARK: - Helpers

extension HTTPHeaderField {
    internal var _value: String {
        if parameters.isEmpty {
            return value
        }
        return "\(value); \(parameters._text)"
    }
    
    internal var _text: String {
        return "\(Self.name): \(_value)"
    }
    
    internal var _data: Data {
        return Data(_text.utf8)
    }
}
