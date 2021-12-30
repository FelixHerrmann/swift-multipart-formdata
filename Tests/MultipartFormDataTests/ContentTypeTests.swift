//
//  ContentTypeTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class ContentTypeTests: XCTestCase {
    
    func testBoundaryParameters() throws {
        let contentType = ContentType(boundary: try Boundary(uncheckedBoundary: "test"))
        
        XCTAssertEqual(contentType.parameters[0], HTTPHeaderParameter("boundary", value: "test"))
    }
    
    func testData() {
        let contentType = ContentType(mediaType: .textPlain, parameters: [HTTPHeaderParameter("test", value: "a")])
        
        XCTAssertEqual(contentType._data, Data("Content-Type: text/plain; test=\"a\"".utf8))
    }
}
