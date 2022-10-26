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
            
            // buildArray
            for i in 0...2 {
                Data(i.description.utf8)
            }
            
            // buildOptional
            if true {
                Data("true".utf8)
            }
            
            // buildEither
            if .random() {
                Data("random".utf8)
            } else {
                Data("random".utf8)
            }
        }
        XCTAssertEqual(data, Data("012truerandom".utf8))
    }
}

extension BodyDataBuilderTests {
    
    private func _buildData(@BodyDataBuilder builder: () throws -> Data) rethrows -> Data {
        try builder()
    }
}
