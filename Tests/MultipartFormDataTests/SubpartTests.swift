//
//  SubpartTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class SubpartTests: XCTestCase {
    func testDataGeneration() throws {
        let subpart = Subpart(
            contentDisposition: ContentDisposition(name: "a"),
            contentType: ContentType(mediaType: .textPlain),
            body: Data("a".utf8)
        )
        let expectedData = Data([
            "Content-Disposition: form-data; name=\"a\"",
            "Content-Type: text/plain",
            "",
            "a",
        ].joined(separator: "\r\n").utf8)
        XCTAssertEqual(subpart._data, expectedData)
    }
    
    func testDebugDescription() {
        let subpart = Subpart(
            contentDisposition: ContentDisposition(name: "a"),
            contentType: ContentType(mediaType: .textPlain),
            body: Data("a".utf8)
        )
        
        let expectedDescription = [
            "Content-Disposition: form-data; name=\"a\"",
            "Content-Type: text/plain",
            "",
            "a",
        ].joined(separator: "\r\n")
        XCTAssertEqual(subpart.debugDescription, expectedDescription)
    }
}
