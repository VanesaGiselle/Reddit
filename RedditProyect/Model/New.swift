//
//  New.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 10/04/2023.
//

import Foundation

class New: Equatable {
    var id: String
    var thumbnail: String?
    var title: String
    var author: String
    var numComments: Int
    var description: String = "Hola"
    
    var read: Bool {
        let readNewsIds = UserConfiguration().getNewsId()
        
        for readNewsId in readNewsIds {
            if self.id == readNewsId {
                return true
            }
        }
        return false
    }
    
    // Random date was created because API is deprecated and don't have dates.
    lazy var date: Date = {
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
    }()
    
    init(id: String, thumbnail: String?, title: String, author: String, numComments: Int) {
        self.id = id
        self.thumbnail = thumbnail
        self.title = title
        self.author = author
        self.numComments = numComments
    }
    
    static func ==(left: New, right: New) -> Bool {
        return left.id == right.id
    }
}
