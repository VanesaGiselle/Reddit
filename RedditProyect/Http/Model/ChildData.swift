//
//  ChildData.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 10/04/2023.
//

import Foundation

struct ChildData: Codable {
    let id: String
    let thumbnail: String
    let title: String
    let author: String
    let visited: Bool
    let numComments: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case thumbnail
        case title
        case author
        case visited
        case numComments = "num_comments"
    }
}
