//
//  Boundary.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import Foundation
   
/// The boundary used by the form data.
///
/// There are 2 ways to create a boundary:
/// 1. ``random()`` type method to generate a random one.
/// 2. ``init(uncheckedBoundary:)`` to create one manually.
///   In this case an error can be thrown because it checks the required format!
public struct Boundary: Hashable {
    
    internal let _asciiData: Data
}


// MARK: - Unchecked Boundary

extension Boundary {
    
    /// All possible errors from ``init(uncheckedBoundary:)``.
    public enum InvalidBoundaryError: Error, CustomDebugStringConvertible {
        
        /// The given boundary was empty.
        ///
        /// It must contain at least one character.
        case empty
        
        /// The given boundary is greater than 70 bytes.
        ///
        /// 1 byte corresponds to 1 character.
        case tooLong
        
        /// The given boundary contains at least on character which is not in ASCII format.
        case noASCII
        
        public var debugDescription: String {
            switch self {
            case .empty: return "Boundary must not be empty."
            case .tooLong: return "Boundary is too long. Max size is 70 characters."
            case .noASCII: return "Boundary contains at least one character that is not ASCII compatible."
            }
        }
    }
    
    /// The maximum allowed size (in bytes).
    ///
    /// 1 byte corresponds to 1 character.
    /// The raw value is `70`.
    public static let maxSize = 70
    
    /// Create a boundary manually from a String.
    ///
    /// The characters must be in ASCII format and the size must not be greater then ``maxSize``.
    /// This initializer check's for a valid format and can throw an error.
    ///
    /// - Parameter uncheckedBoundary: The unchecked, raw boundary value.
    /// - Throws: An error of type ``InvalidBoundaryError``.
    public init(uncheckedBoundary: String) throws {
        guard !uncheckedBoundary.isEmpty else {
            throw InvalidBoundaryError.empty
        }
        guard uncheckedBoundary.count <= Self.maxSize else {
            throw InvalidBoundaryError.tooLong
        }
        guard !uncheckedBoundary.contains(where: { !$0.isASCII }), let asciiData = uncheckedBoundary.data(using: .ascii) else {
            throw InvalidBoundaryError.noASCII
        }
        self._asciiData = asciiData
    }
}


// MARK: - Random Boundary

extension Boundary {
    
    /// Generates a random boundary with 16 ASCII characters.
    ///
    /// A valid boundary is guaranteed and no error can be thrown.
    ///
    /// - Returns: The generated boundary.
    public static func random() -> Boundary {
        let first = UInt32.random(in: UInt32.min...UInt32.max)
        let second = UInt32.random(in: UInt32.min...UInt32.max)
        let rawValue = String(format: "%08x%08x", first, second)
        let asciiData = Data(rawValue.utf8) // UTF8 is fine here because we can ensure it's ASCII compatible
        return Boundary(_asciiData: asciiData)
    }
}


// MARK: - Debug

extension Boundary: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return _value
    }
}


// MARK: - Helpers

extension Boundary {
    
    internal var _value: String {
        return String(decoding: _asciiData, as: UTF8.self) // UTF-8 representation is exactly equivalent to ASCII
    }
}
