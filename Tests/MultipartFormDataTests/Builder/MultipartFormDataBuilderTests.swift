//
//  MultipartFormDataBuilderTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 30.12.21.
//

import XCTest
@testable import MultipartFormData

final class MultipartFormDataBuilderTests: XCTestCase {
    
    func testSingleSubpart() throws {
        let subparts = _buildSubparts {
            Subpart {
                ContentDisposition(name: "a")
            } body: {
                Data("a".utf8)
            }
        }
        let expectedSubparts = [
            Subpart(contentDisposition: ContentDisposition(name: "a"), body: Data("a".utf8))
        ]
        XCTAssertEqual(subparts, expectedSubparts)
    }
    
    func testMultipleSubparts() throws {
        let subparts = _buildSubparts {
            Subpart {
                ContentDisposition(name: "a")
            } body: {
                Data("a".utf8)
            }
            Subpart {
                ContentDisposition(name: "b")
            } body: {
                Data("b".utf8)
            }
            Subpart {
                ContentDisposition(name: "c")
            } body: {
                Data("c".utf8)
            }
        }
        let expectedSubparts = [
            Subpart(contentDisposition: ContentDisposition(name: "a"), body: Data("a".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "b"), body: Data("b".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "c"), body: Data("c".utf8)),
        ]
        XCTAssertEqual(subparts, expectedSubparts)
    }
    
    func testAllBuildMethods() throws {
        let subparts = try _buildSubparts {
            // buildArray(_:)
            for index in 0...2 {
                try Subpart {
                    try ContentDisposition(uncheckedName: index.description)
                } body: {
                    Data(index.description.utf8)
                }
            }
            
            // buildOptional(_:)
            if Bool(truncating: 1) {
                Subpart {
                    ContentDisposition(name: "true")
                } body: {
                    Data("true".utf8)
                }
            }
            if Bool(truncating: 0) {
                Subpart {
                    ContentDisposition(name: "true")
                } body: {
                    Data("true".utf8)
                }
            }
            
            // buildEither(first:)
            if Bool(truncating: 1) {
                Subpart {
                    ContentDisposition(name: "first")
                } body: {
                    Data("first".utf8)
                }
            } else {
                Subpart {
                    ContentDisposition(name: "second")
                } body: {
                    Data("second".utf8)
                }
            }
            
            // buildEither(second:)
            if Bool(truncating: 0) {
                Subpart {
                    ContentDisposition(name: "first")
                } body: {
                    Data("first".utf8)
                }
            } else {
                Subpart {
                    ContentDisposition(name: "second")
                } body: {
                    Data("second".utf8)
                }
            }
        }
        let expectedSubparts = [
            Subpart(contentDisposition: ContentDisposition(name: "0"), body: Data("0".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "1"), body: Data("1".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "2"), body: Data("2".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "true"), body: Data("true".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "first"), body: Data("first".utf8)),
            Subpart(contentDisposition: ContentDisposition(name: "second"), body: Data("second".utf8)),
        ]
        XCTAssertEqual(subparts, expectedSubparts)
    }
}

extension MultipartFormDataBuilderTests {
    private func _buildSubparts(@MultipartFormDataBuilder builder: () throws -> [Subpart]) rethrows -> [Subpart] {
        return try builder()
    }
}
