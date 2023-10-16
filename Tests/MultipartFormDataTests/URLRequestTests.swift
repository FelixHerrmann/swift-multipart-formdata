//
//  URLRequestTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 30.12.21.
//

import XCTest
@testable import MultipartFormData
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class URLRequestTests: XCTestCase {
    func testFormDataInit() throws {
        let boundary = try Boundary(uncheckedBoundary: "test")
        let multipartFormData = MultipartFormData(boundary: boundary, body: [
            Subpart(contentDisposition: ContentDisposition(name: "a"), body: Data())
        ])
        // swiftlint:disable:next force_unwrapping
        let request = URLRequest(url: URL(string: "https://test.com/test")!, multipartFormData: multipartFormData)
        
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "multipart/form-data; boundary=\"test\"")
        
        let expectedBody = Data([
            "--test",
            "Content-Disposition: form-data; name=\"a\"",
            "",
            "",
            "--test--\r\n",
        ].joined(separator: "\r\n").utf8)
        XCTAssertEqual(request.httpBody, expectedBody)
    }
    
    func testHeaderField() {
        // swiftlint:disable:next force_unwrapping
        var request = URLRequest(url: URL(string: "https://test.com/test")!)
        let contentType = ContentType(mediaType: .textPlain, parameters: [HTTPHeaderParameter("test", value: "a")])
        request.updateHeaderField(with: contentType)
        
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "text/plain; test=\"a\"")
    }
}
