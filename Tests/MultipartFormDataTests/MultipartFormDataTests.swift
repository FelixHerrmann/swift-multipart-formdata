//
//  MultipartFormDataTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class MultipartFormDataTests: XCTestCase {
    
    func testContentType() throws {
        let boundary = try Boundary(uncheckedBoundary: "test")
        let multipartFormData = MultipartFormData(boundary: boundary)
        XCTAssertEqual(multipartFormData.contentType._data, Data("Content-Type: multipart/form-data; boundary=\"test\"".utf8))
    }
    
    func testHTTPBodyGeneration() throws {
        let boundary = try Boundary(uncheckedBoundary: "test")
        let multipartFormData = MultipartFormData(boundary: boundary, body: [
            Subpart(contentDisposition: ContentDisposition(name: "text"), body: Data("a".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "json"), contentType: ContentType(mediaType: .applicationJson), body: try JSONSerialization.data(withJSONObject: ["a": 1])),
            Subpart(contentDisposition: ContentDisposition(name: "file", filename: "test.txt"), contentType: ContentType(mediaType: .applicationOctetStream), body: Data()),
        ])
        
        let expectedBody = Data([
            "--test",
            "Content-Disposition: form-data; name=\"text\"",
            "",
            "a",
            "--test",
            "Content-Disposition: form-data; name=\"json\"",
            "Content-Type: application/json",
            "",
            "{\"a\":1}",
            "--test",
            "Content-Disposition: form-data; name=\"file\"; filename=\"test.txt\"",
            "Content-Type: application/octet-stream",
            "",
            "",
            "--test--"
        ].joined(separator: "\r\n").utf8)
        XCTAssertEqual(multipartFormData.httpBody, expectedBody)
    }
    
    func testDebugDescription() throws {
        let boundary = try Boundary(uncheckedBoundary: "test")
        let multipartFormData = MultipartFormData(boundary: boundary, body: [
            Subpart(contentDisposition: ContentDisposition(name: "text"), body: Data("a".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "json"), contentType: ContentType(mediaType: .applicationJson), body: try JSONSerialization.data(withJSONObject: ["a": 1])),
            Subpart(contentDisposition: ContentDisposition(name: "file", filename: "test.txt"), contentType: ContentType(mediaType: .applicationOctetStream), body: Data()),
        ])
        
        let expectedDescription = [
            "Content-Type: multipart/form-data; boundary=\"test\"",
            "",
            "--test",
            "Content-Disposition: form-data; name=\"text\"",
            "",
            "a",
            "--test",
            "Content-Disposition: form-data; name=\"json\"",
            "Content-Type: application/json",
            "",
            "{\"a\":1}",
            "--test",
            "Content-Disposition: form-data; name=\"file\"; filename=\"test.txt\"",
            "Content-Type: application/octet-stream",
            "",
            "",
            "--test--"
        ].joined(separator: "\r\n")
        XCTAssertEqual(multipartFormData.debugDescription, expectedDescription)
    }
}
