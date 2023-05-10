//
//  New.swift
//  Reddit
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
        let currentDate = Date()
        let backDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        guard let backDate = backDate else {
            return Date()
        }
        return Date.random(in: backDate..<currentDate)
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
