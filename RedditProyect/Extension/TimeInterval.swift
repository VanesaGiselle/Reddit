//
//  TimeInterval.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 11/04/2023.
//

import Foundation

extension TimeInterval {
    func asMinutes() -> Int { return Int(self / (60.0)) }
    func asHours()   -> Int { return Int(self / (60.0 * 60.0)) }
    func asDays()    -> Int { return Int(self / (60.0 * 60.0 * 24.0)) }
    func asWeeks()   -> Int { return Int(self / (60.0 * 60.0 * 24.0 * 7.0)) }
    func asMonths()  -> Int { return Int(self / (60.0 * 60.0 * 24.0 * 30.4369)) }
    func asYears()   -> Int { return Int(self / (60.0 * 60.0 * 24.0 * 365.2422)) }
}
