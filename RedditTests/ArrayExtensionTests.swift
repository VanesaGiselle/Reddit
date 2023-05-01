//
//  ArrayExtension.swift
//  RedditTests
//
//  Created by Vanesa Korbenfeld on 17/04/2023.
//

import XCTest
@testable import Reddit

class ArrayExtensionTests: XCTestCase {
    func testTwoEqualElements_ShouldReturnJustOne() {
        let array = [1,2,1]
        let expected = [1,2]
        XCTAssertEqual(array.getUniqueElements(), expected)
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
