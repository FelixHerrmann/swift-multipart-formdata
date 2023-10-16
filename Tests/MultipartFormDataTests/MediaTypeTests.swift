//
//  MediaTypeTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
#if canImport(UniformTypeIdentifiers)
import UniformTypeIdentifiers
#endif
@testable import MultipartFormData

final class MediaTypeTests: XCTestCase {
    func testText() {
        let mediaType = MediaType(type: "type", subtype: "subtype")
        XCTAssertEqual(mediaType._text, "type/subtype")
    }
    
    func testDebugDescription() {
        let mediaType = MediaType(type: "type", subtype: "subtype")
        
        let expectedDescription = "type/subtype"
        XCTAssertEqual(mediaType.debugDescription, expectedDescription)
    }
#if canImport(UniformTypeIdentifiers)
    
    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func testFromUTTypeConversion() throws {
        let uniformType = try XCTUnwrap(UTType("public.comma-separated-values-text"))
        let mediaType = try XCTUnwrap(MediaType(uniformType: uniformType))
        
        XCTAssertEqual(mediaType, .textCsv)
    }
    
    @available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *)
    func testToUTTypeConversion() throws {
        let uniformType = try XCTUnwrap(UTType(mediaType: .applicationJson))
        
        XCTAssertEqual(uniformType.identifier, "public.json")
    }
#endif
}
