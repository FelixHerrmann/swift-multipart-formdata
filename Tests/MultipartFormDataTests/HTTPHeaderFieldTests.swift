//
//  HTTPHeaderFieldTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 05.03.23.
//

import XCTest
@testable import MultipartFormData

final class HTTPHeaderFieldTests: XCTestCase {
    
    func testDebugDescription() {
        let parameter = HTTPHeaderParameter("name", value: "value")
        let testHeaderField = TestHeaderField(value: "value", parameters: [parameter])
        
        let expectedDescription = "Test: value; name=\"value\""
        XCTAssertEqual(testHeaderField.debugDescription, expectedDescription)
    }
}

extension HTTPHeaderFieldTests {
    private struct TestHeaderField: HTTPHeaderField {
        static let name: String = "Test"
        
        var value: String
        
        var parameters: [HTTPHeaderParameter]
        
        init(value: String, parameters: [HTTPHeaderParameter]) {
            self.value = value
            self.parameters = parameters
        }
    }
}
