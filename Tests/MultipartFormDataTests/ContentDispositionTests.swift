//
//  ContentDispositionTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class ContentDispositionTests: XCTestCase {
    
    func testPercentEncodingError() throws {
        XCTAssertNoThrow(try ContentDisposition(uncheckedName: "a", uncheckedFilename: "a"))
        
        // https://stackoverflow.com/questions/33558933/why-is-the-return-value-of-string-addingpercentencoding-optional
        // does not work on Linux, can still encoding there
        let nonPercentEncodableString = try XCTUnwrap(String(bytes: [0xD8, 0x00] as [UInt8], encoding: .utf16BigEndian))
        if nonPercentEncodableString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) == nil {
            XCTAssertThrowsError(try ContentDisposition(uncheckedName: nonPercentEncodableString, uncheckedFilename: nil))
            XCTAssertThrowsError(try ContentDisposition(uncheckedName: "", uncheckedFilename: nonPercentEncodableString))
        }
    }
    
    func testParameters() throws {
        let contentDisposition = ContentDisposition(name: "a", filename: "a")
        
        XCTAssertEqual(contentDisposition.parameters[0], HTTPHeaderParameter("name", value: "a"))
        XCTAssertEqual(contentDisposition.parameters[1], HTTPHeaderParameter("filename", value: "a"))
    }
    
    func testData() throws {
        let contentDisposition = ContentDisposition(name: "a", filename: "a")
        
        XCTAssertEqual(contentDisposition._data, Data("Content-Disposition: form-data; name=\"a\"; filename=\"a\"".utf8))
    }
}
