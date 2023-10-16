//
//  BodyDataBuilderTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class BodyDataBuilderTests: XCTestCase {
    func testSingleData() {
        let data = _buildData {
            Data("a".utf8)
        }
        XCTAssertEqual(data, Data("a".utf8))
    }
    
    func testMultipleData() {
        let data = _buildData {
            Data("a".utf8)
            Data("b".utf8)
            Data("c".utf8)
            Data("d".utf8)
        }
        XCTAssertEqual(data, Data("abcd".utf8))
    }
    
    func testAllBuildMethods() {
        let data = _buildData {
            // buildArray(_:)
            for index in 0...2 {
                Data(index.description.utf8)
            }
            
            // buildOptional(_:)
            if Bool(truncating: 1) {
                Data("true".utf8)
            }
            if Bool(truncating: 0) {
                Data("false".utf8)
            }
            
            // buildEither(first:)
            if Bool(truncating: 1) {
                Data("first".utf8)
            } else {
                Data("second".utf8)
            }
            
            // buildEither(second:)
            if Bool(truncating: 0) {
                Data("first".utf8)
            } else {
                Data("second".utf8)
            }
        }
        XCTAssertEqual(data, Data("012truefirstsecond".utf8))
    }
}

extension BodyDataBuilderTests {
    private func _buildData(@BodyDataBuilder builder: () throws -> Data) rethrows -> Data {
        return try builder()
    }
}
