//
//  BodyDataBuilder.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import Foundation

/// Build data for the ``Subpart``'s body.
///
/// The returning object is always a single `Data` instance, it will be combined in the case of multiple `Data` components.
@resultBuilder
public enum BodyDataBuilder {
    
    public static func buildExpression(_ expression: Data) -> Data {
        expression
    }
    
    public static func buildBlock(_ components: Data...) -> Data {
        components.reduce(Data(), +)
    }
    
    public static func buildArray(_ components: [Data]) -> Data {
        components.reduce(Data(), +)
    }
    
    public static func buildOptional(_ component: Data?) -> Data {
        component ?? Data()
    }
    
    public static func buildEither(first component: Data) -> Data {
        component
    }
    
    public static func buildEither(second component: Data) -> Data {
        component
    }
}
