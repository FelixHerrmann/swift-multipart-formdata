//
//  MediaTypeTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
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
}
