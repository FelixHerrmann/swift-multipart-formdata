//
//  BoundaryTests.swift
//  swift-multipart-formdata
//
//  Created by Felix Herrmann on 29.12.21.
//

import XCTest
@testable import MultipartFormData

final class BoundaryTests: XCTestCase {
    
    func testEmpty() {
        XCTAssertThrowsError(try Boundary(uncheckedBoundary: "")) { error in
            XCTAssertEqual(error as? Boundary.InvalidBoundaryError, .empty)
        }
    }
    
    func testTooLong() {
        var tooLongBoundary = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrs"
        
        XCTAssertEqual(tooLongBoundary.count, 71)
        XCTAssertThrowsError(try Boundary(uncheckedBoundary: tooLongBoundary)) { error in
            XCTAssertEqual(error as? Boundary.InvalidBoundaryError, .tooLong)
        }
        
        tooLongBoundary.removeLast()
        XCTAssertEqual(tooLongBoundary.count, 70)
        XCTAssertNoThrow(try Boundary(uncheckedBoundary: tooLongBoundary))
    }
    
    func testNoAscii() {
        let noAsciiString = "abcdefghijklmnopqrstuvwxyz\u{80}"
        XCTAssertTrue(noAsciiString.contains { !$0.isASCII })
        XCTAssertThrowsError(try Boundary(uncheckedBoundary: noAsciiString)) { error in
            XCTAssertEqual(error as? Boundary.InvalidBoundaryError, .noASCII)
        }
        
        let asciiString = "abcdefghijklmnopqrstuvwxyz"
        XCTAssertFalse(asciiString.contains { !$0.isASCII })
        XCTAssertNoThrow(try Boundary(uncheckedBoundary: asciiString))
    }
    
    func testRandom() {
        for _ in 0...100_000 {
            let randomBoundary = Boundary.random()
            let asciiString = String(data: randomBoundary._asciiData, encoding: .ascii)
            XCTAssertNotNil(asciiString)
            XCTAssertEqual(asciiString, randomBoundary._value)
        }
    }
    
    func testDebugDescription() throws {
        let boundary = try Boundary(uncheckedBoundary: "test")
        
        let expectedDescription = "test"
        XCTAssertEqual(boundary.debugDescription, expectedDescription)
    }
}
