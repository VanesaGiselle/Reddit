//
//  PaginationTests.swift
//  RedditProyectTests
//
//  Created by Vanesa Korbenfeld on 21/04/2023.
//

import XCTest
@testable import RedditProyect

class PaginationTests: XCTestCase {
    func testTwoEqualElements_ShouldReturnJustOne() {
        var pagination = Pagination()
        pagination.newsProvider = MockNewsProvider()
//        pagination.getFirstPage { Result<[New], ErrorType> in
//        }
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

//class MockNewsProvider: NewsProvider {
//    func getNews(completionHandler: @escaping (Result<News, ErrorType>) -> Void, limit: String?) {
//        completionHandler(.success(
//            News(
//                data: RedditProyect.Data(children: [
//                    New(id: "1", thumbnail: "", title: "title1", author: "author1", numComments: 5),
//                    New(id: "2", thumbnail: "", title: "title1", author: "author1", numComments: 5),
//                    New(id: "3", thumbnail: "", title: "title1", author: "author1", numComments: 5),
//                    New(id: "4", thumbnail: "", title: "title1", author: "author1", numComments: 5),
//                    New(id: "1", thumbnail: "", title: "title1", author: "author1", numComments: 5)
//                ]
//                                        )
//
//                )
//            )
//        )
//                          }
//}
