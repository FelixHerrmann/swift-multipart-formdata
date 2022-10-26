//
//  MultipartFormDataBuilder.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

/// Build the subparts for a ``MultipartFormData``.
@resultBuilder
public enum MultipartFormDataBuilder {
    
    public static func buildExpression(_ expression: Subpart) -> [Subpart] {
        [expression]
    }
    
    public static func buildBlock(_ components: [Subpart]...) -> [Subpart] {
        components.flatMap { $0 }
    }
    
    public static func buildBlock(_ components: Subpart...) -> [Subpart] {
        components
    }
    
    public static func buildArray(_ components: [[Subpart]]) -> [Subpart] {
        components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [Subpart]?) -> [Subpart] {
        component ?? []
    }
    
    public static func buildEither(first component: [Subpart]) -> [Subpart] {
        component
    }
    
    public static func buildEither(second component: [Subpart]) -> [Subpart] {
        component
    }
}
