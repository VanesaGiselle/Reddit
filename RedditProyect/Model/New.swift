//
//  New.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 10/04/2023.
//

import Foundation

class New {
    var id: String
    var thumbnail: String?
    var title: String
    var author: String
    var numComments: Int
    var visited: Bool
    
    // Random date was created because API is deprecated and don't have dates.
    var date: Date {
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        guard
            let days = calendar.range(of: .day, in: .year, for: date),
            let randomDay = days.randomElement(),
            let hours = calendar.range(of: .hour, in: .day, for: date),
            let randomHour = hours.randomElement(),
            let minutes = calendar.range(of: .minute, in: .hour, for: date),
            let randomMinute = minutes.randomElement()
        else {
                return Date()
        }
        dateComponents.setValue(randomDay, for: .day)
        dateComponents.setValue(randomHour, for: .hour)
        dateComponents.setValue(randomMinute, for: .hour)
        return calendar.date(from: dateComponents) ?? Date()
    }
    
    init(id: String, thumbnail: String?, title: String, author: String, date: String?, numComments: Int, visited: Bool) {
        self.id = id
        self.thumbnail = thumbnail
        self.title = title
        self.author = author
        self.numComments = numComments
        self.visited = visited
    }
}
