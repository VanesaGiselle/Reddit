//
//  PaginationTests.swift
//  RedditTests
//
//  Created by Vanesa Korbenfeld on 21/04/2023.
//

import XCTest
@testable import Reddit

class PaginationTests: XCTestCase {
    func testTwoEqualElements_ShouldReturnJustOne() {
    }
    
    func testAllDifferentElements_ShouldReturnTheSame() {
        let array = [1,2,3]
        let expected = [1,2,3]
        XCTAssertEqual(array.getUniqueElements(), expected)
    }
    
    func testEmptyArray_ShouldReturnEmptyArray() {
        let array = Array<Int>()
        let expected = Array<Int>()
        XCTAssertEqual(array.getUniqueElements(), expected)
    }
}
