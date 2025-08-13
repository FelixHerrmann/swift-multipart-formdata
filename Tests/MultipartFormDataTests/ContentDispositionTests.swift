//
//  ContentDispositionTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class ContentDispositionTests: XCTestCase {
    func testUncheckedInitValid() {
        XCTAssertNoThrow(try ContentDisposition(uncheckedName: "a", uncheckedFilename: "a"))
    }
    
    func testUncheckedInitInvalid() throws {
        // https://stackoverflow.com/questions/33558933/why-is-the-return-value-of-string-addingpercentencoding-optional
        let bytes: [UInt8] = [0xD8, 0x00]
        
        // Ensure the non-encodable string can be created, e.g. on iOS 18 it no longer works.
        guard let nonPercentEncodableString = String(bytes: bytes, encoding: .utf16BigEndian) else {
            throw XCTSkip("UTF16 byte encoding failed")
        }
        
        // Ensure the percent-encoding fails on the current platform, e.g. on Linux it encodes.
        guard nonPercentEncodableString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) == nil else {
            throw XCTSkip("percent encoding didn't fail")
        }
        
        XCTAssertThrowsError(try ContentDisposition(uncheckedName: nonPercentEncodableString, uncheckedFilename: nil))
        XCTAssertThrowsError(try ContentDisposition(uncheckedName: "", uncheckedFilename: nonPercentEncodableString))
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
