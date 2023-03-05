//
//  HTTPHeaderBuilderTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class HTTPHeaderBuilderTests: XCTestCase {
    
    func testAvailableHeaderCombinations() {
        let dispositionResult = _buildHeader {
            ContentDisposition(name: "a")
        }
        XCTAssertEqual(dispositionResult._contentDisposition, ContentDisposition(name: "a"))
        XCTAssertNil(dispositionResult._contentType)
        
        let dispositionTypeResult = _buildHeader {
            ContentDisposition(name: "a")
            ContentType(mediaType: .textPlain)
        }
        XCTAssertEqual(dispositionTypeResult._contentDisposition, ContentDisposition(name: "a"))
        XCTAssertEqual(dispositionTypeResult._contentType, ContentType(mediaType: .textPlain))
        
        let typeDispositionResult = _buildHeader {
            ContentType(mediaType: .textPlain)
            ContentDisposition(name: "a")
        }
        XCTAssertEqual(typeDispositionResult._contentDisposition, ContentDisposition(name: "a"))
        XCTAssertEqual(typeDispositionResult._contentType, ContentType(mediaType: .textPlain))
    }
    
    func testAllBuildMethods() {
        let buildResult = _buildHeader {
            // buildEither(first:)
            if Bool(truncating: 1) {
                ContentDisposition(name: "a")
            } else {
                ContentDisposition(name: "a")
            }
        }
        XCTAssertEqual(buildResult._contentDisposition, ContentDisposition(name: "a"))
        
        let buildResult2 = _buildHeader {
            // buildEither(second:)
            if Bool(truncating: 0) {
                ContentDisposition(name: "b")
            } else {
                ContentDisposition(name: "b")
            }
        }
        XCTAssertEqual(buildResult2._contentDisposition, ContentDisposition(name: "b"))
    }
}

extension HTTPHeaderBuilderTests {
    private func _buildHeader(
        @HTTPHeaderBuilder builder: () throws -> HTTPHeaderBuilder.BuildResult
    ) rethrows -> HTTPHeaderBuilder.BuildResult {
        return try builder()
    }
}
