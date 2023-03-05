//
//  HTTPHeaderParameter.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

/// A parameter for an ``HTTPHeaderField``.
public struct HTTPHeaderParameter: Hashable {
    
    /// The name of the parameter.
    public var name: String
    
    /// The value of the parameter.
    public var value: String
    
    /// Creates a new ``HTTPHeaderParameter`` object.
    /// - Parameters:
    ///   - name: The name of the parameter.
    ///   - value: The value of the parameter.
    public init(_ name: String, value: String) {
        self.name = name
        self.value = value
    }
}

// MARK: - Debug

extension HTTPHeaderParameter: CustomDebugStringConvertible {
    public var debugDescription: String {
        return _text
    }
}

// MARK: - Helpers

extension HTTPHeaderParameter {
    internal var _text: String {
        return "\(name)=\"\(value)\""
    }
}

extension Array<HTTPHeaderParameter> {
    internal var _text: String {
        return map(\._text).joined(separator: "; ")
    }
}
