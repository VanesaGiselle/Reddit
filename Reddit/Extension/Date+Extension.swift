//
//  Date+Extension.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 11/04/2023.
//

import Foundation

extension Date {
    static func random(in range: Range<Date>) -> Date {
        Date(
            timeIntervalSinceNow: .random(
                in: range.lowerBound.timeIntervalSinceNow...range.upperBound.timeIntervalSinceNow
            )
        )
    }
    
    static func - (recent: Date, previous: Date) -> (year: Int?, month: Int?, week: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let year = Calendar.current.dateComponents([.year], from: previous, to: recent).year
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let week = Calendar.current.dateComponents([.weekOfYear], from: previous, to: recent).weekOfYear
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (year: year, month: month, week: week, day: day, hour: hour, minute: minute, second: second)
    }
    
    func getDateInterval(interval: (year: Int?, month: Int?, week: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?)) -> String {
        if let years = interval.year, years != 0 {
            return "\(years)" + (years == 1 ?  " year" : " years") + " ago"
        }
        
        if let months = interval.month, months != 0 {
            return "\(months)" + (months == 1 ?  " month" : " months") + " ago"
        }
        
        if let weeks = interval.week, weeks != 0 {
           return "\(weeks)" + (weeks == 1 ?  " week" : " weeks") + " ago"
        }
        
        if let days = interval.day, days != 0  {
           return "\(days)" + (days == 1 ?  " day" : " days") + " ago"
        }
        
        if let hours = interval.hour, hours != 0  {
            return "\(hours)" + (hours == 1 ?  " hour" : " hours") + " ago"
        }
        
        if let minutes = interval.minute, minutes != 0  {
           return "\(minutes)" + (minutes == 1 ?  " min" : " mins") + " ago"
        }
        
        if let seconds = interval.second, seconds != 0 {
           return "\(seconds)" + (seconds == 1 ?  " sec" : " secs") + " ago"
        }
        
        return ""
    }
    
    func getDateDifferenceToNow() -> (year: Int?, month: Int?, week: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        return Date() - self
    }
    
    func getDateDifference(to: Date) -> (year: Int?, month: Int?, week: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        return to - self
    }
}
