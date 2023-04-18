//
//  NewDateTests.swift
//  RedditProyectTests
//
//  Created by Vanesa Korbenfeld on 17/04/2023.
//

import XCTest
@testable import RedditProyect

class DateExtensionTests: XCTestCase {
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-d HH:mm:ss"
        return formatter
    }()
    
    func testDateWithYearsDifference_ShouldReturnYearsInPlural() {
        let sinceDateString = "2020-3-1 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "3 years ago")
    }
    
    func testDateWithMonthsDifference_ShouldReturnMonths() {
        let sinceDateString = "2023-2-25 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 month ago")
    }
    
    func testDateWithWeekDifference_ShouldReturnWeeks() {
        let sinceDateString = "2023-4-4 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 week ago")
    }
}
