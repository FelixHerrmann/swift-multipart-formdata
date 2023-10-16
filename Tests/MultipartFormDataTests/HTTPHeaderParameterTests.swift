//
//  HTTPHeaderParameterTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class HTTPHeaderParameterTests: XCTestCase {
    func testArrayText() {
        let singleParameter = [
            HTTPHeaderParameter("test", value: "a")
        ]
        XCTAssertEqual(singleParameter._text, "test=\"a\"")
        
        let parameters = [
            HTTPHeaderParameter("test", value: "a"),
            HTTPHeaderParameter("test", value: "a"),
            HTTPHeaderParameter("test", value: "a"),
        ]
        XCTAssertEqual(parameters._text, "test=\"a\"; test=\"a\"; test=\"a\"")
    }
    
    func testDebugDescription() {
        let parameter = HTTPHeaderParameter("test", value: "a")
        
        let expectedDescription = "test=\"a\""
        XCTAssertEqual(parameter.debugDescription, expectedDescription)
    }
}
