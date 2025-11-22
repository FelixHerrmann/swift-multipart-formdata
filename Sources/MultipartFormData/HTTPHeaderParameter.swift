//
//  HTTPHeaderParameter.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

/// A parameter for an ``HTTPHeaderField``.
public struct HTTPHeaderParameter: Sendable, Hashable {
    
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
        return rawValue
    }
}

// MARK: - Helpers

extension HTTPHeaderParameter {
    /// The raw string representation of a header parameter.
    public var rawValue: String {
        return "\(name)=\"\(value)\""
    }
}

extension Array<HTTPHeaderParameter> {
    /// The raw string representation of multiple header parameters.
    public var rawValue: String {
        return map(\.rawValue).joined(separator: "; ")
    }
}
