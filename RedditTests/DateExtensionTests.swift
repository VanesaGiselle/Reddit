//
//  NewDateTests.swift
//  RedditTests
//
//  Created by Vanesa Korbenfeld on 17/04/2023.
//

import XCTest
@testable import Reddit

class DateExtensionTests: XCTestCase {
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-d HH:mm:ss"
        return formatter
    }()
    
    // PLURAL - More than one unit difference
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
    
    func testDateWithMonthsDifference_ShouldReturnMonthsInPlural() {
        let sinceDateString = "2023-2-16 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "2 months ago")
    }
    
    func testDateWithWeekDifference_ShouldReturnWeeksInPlural() {
        let sinceDateString = "2023-4-1 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "2 weeks ago")
    }
    
    func testDateWithDaysDifference_ShouldReturnDaysInPlural() {
        let sinceDateString = "2023-4-15 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "2 days ago")
    }
    
    func testDateWithHoursDifference_ShouldReturnHoursInPlural() {
        let sinceDateString = "2023-4-17 15:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 17:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "2 hours ago")
    }
    
    func testDateWithMinutesDifference_ShouldReturnMinutesInPlural() {
        let sinceDateString = "2023-4-17 17:23:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 17:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "10 mins ago")
    }
    
    func testDateWithSecondsDifference_ShouldReturnSecondsInPlural() {
        let sinceDateString = "2023-4-17 17:33:33"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 17:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "10 secs ago")
    }
    
    // SINGULAR - One unit difference
    func testDateWithYearDifference_ShouldReturnYearInSingular() {
        let sinceDateString = "2022-4-16 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 year ago")
    }
    
    func testDateWithMonthDifference_ShouldReturnMonthInSingular() {
        let sinceDateString = "2023-3-16 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 month ago")
    }
    
    func testDateWithWeekDifference_ShouldReturnWeekInSingular() {
        let sinceDateString = "2023-4-10 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 week ago")
    }
    
    func testDateWithDayDifference_ShouldReturnDayInSingular() {
        let sinceDateString = "2023-4-16 00:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 00:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 day ago")
    }
    
    func testDateWithHourDifference_ShouldReturnHourInSingular() {
        let sinceDateString = "2023-4-17 16:33:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 17:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 hour ago")
    }
    
    func testDateWithMinuteDifference_ShouldReturnMinuteInSingular() {
        let sinceDateString = "2023-4-17 17:32:43"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 17:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 min ago")
    }
    
    func testDateWithSecondDifference_ShouldReturnSecondInSingular() {
        let sinceDateString = "2023-4-17 17:33:42"
        let sinceDate = formatter.date(from: sinceDateString)
        
        let toDateString = "2023-4-17 17:33:43"
        let toDate = formatter.date(from: toDateString)
        
        guard let sinceDate = sinceDate, let toDate = toDate else {
            return
        }
        
        let difference = sinceDate.getDateInterval(interval: sinceDate.getDateDifference(to: toDate))
        XCTAssertEqual(difference, "1 sec ago")
    }
}
