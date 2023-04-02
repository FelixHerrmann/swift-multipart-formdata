//
//  HTTPHeaderBuilder.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

/// Build the header fields for a ``Subpart``.
///
/// The only allowed combinations of header fields are:
/// - ``ContentDisposition``
/// - ``ContentDisposition`` + ``ContentType``
/// - ``ContentType`` + ``ContentDisposition``
///
/// The returning object is of type ``BuildResult``.
@resultBuilder
public enum HTTPHeaderBuilder {
    // swiftlint:disable missing_docs
    
    public static func buildBlock(_ contentDisposition: ContentDisposition) -> BuildResult {
        return BuildResult(_contentDisposition: contentDisposition, _contentType: nil)
    }
    
    public static func buildBlock(_ contentDisposition: ContentDisposition, _ contentType: ContentType) -> BuildResult {
        return BuildResult(_contentDisposition: contentDisposition, _contentType: contentType)
    }
    
    public static func buildBlock(_ contentType: ContentType, _ contentDisposition: ContentDisposition) -> BuildResult {
        return BuildResult(_contentDisposition: contentDisposition, _contentType: contentType)
    }
    
    public static func buildBlock(_ component: BuildResult) -> BuildResult {
        return component
    }
    
    public static func buildEither(first component: BuildResult) -> BuildResult {
        return component
    }
    
    public static func buildEither(second component: BuildResult) -> BuildResult {
        return component
    }
    // swiftlint:enable missing_docs
}

// MARK: - Build Errors

extension HTTPHeaderBuilder {
    // swiftlint:disable missing_docs
    
    @available(*, unavailable, message: "Missing a ContentDisposition")
    public static func buildBlock(_ contentType: ContentType) -> BuildResult {
        fatalError("unavailable")
    }
    
    @available(*, unavailable, message: "Only a single ContentDisposition is allowed")
    public static func buildBlock(_ contentDispositions: ContentDisposition...) -> BuildResult {
        fatalError("unavailable")
    }
    
    @available(*, unavailable, message: "Only a single ContentType is allowed")
    public static func buildBlock(_ contentDisposition: ContentDisposition, _ contentTypes: ContentType...) -> BuildResult {
        fatalError("unavailable")
    }
    // swiftlint:enable missing_docs
}

// MARK: - Build Result

extension HTTPHeaderBuilder {
    /// The return type of ``HTTPHeaderBuilder``.
    ///
    /// This is just a wrapper around ``ContentDisposition`` + ``ContentType`` and only for internal usage.
    public struct BuildResult {
        internal let _contentDisposition: ContentDisposition
        internal let _contentType: ContentType?
    }
}
