//
//  ChildData.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 10/04/2023.
//

import Foundation

struct ChildData: Codable {
    let preview: Preview
    let title: String
    let author: String
    let visited: Bool
    let numComments: Int
    
    private enum CodingKeys: String, CodingKey {
        case preview
        case title
        case author
        case visited
        case numComments = "num_comments"
    }
}
