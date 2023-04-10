//
//  New.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 10/04/2023.
//

import Foundation

class New {
    var thumbnail: String?
    var title: String
    var author: String
    var date: String?
    var numComments: Int
    var visited: Bool
    
    init(thumbnail: String?, title: String, author: String, date: String?, numComments: Int, visited: Bool) {
        self.thumbnail = thumbnail
        self.title = title
        self.author = author
        self.date = date
        self.numComments = numComments
        self.visited = visited
    }
}
