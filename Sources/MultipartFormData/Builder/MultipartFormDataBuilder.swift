//
//  MultipartFormDataBuilder.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

// swiftlint:disable missing_docs
// swiftlint:disable discouraged_optional_collection

/// Build the subparts for a ``MultipartFormData``.
@resultBuilder
public enum MultipartFormDataBuilder {
    
    public static func buildExpression(_ expression: Subpart) -> [Subpart] {
        return [expression]
    }
    
    public static func buildBlock(_ components: [Subpart]...) -> [Subpart] {
        return components.flatMap { $0 }
    }
    
    public static func buildBlock(_ components: Subpart...) -> [Subpart] {
        return components
    }
    
    public static func buildArray(_ components: [[Subpart]]) -> [Subpart] {
        return components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [Subpart]?) -> [Subpart] {
        return component ?? []
    }
    
    public static func buildEither(first component: [Subpart]) -> [Subpart] {
        return component
    }
    
    public static func buildEither(second component: [Subpart]) -> [Subpart] {
        return component
    }
}
