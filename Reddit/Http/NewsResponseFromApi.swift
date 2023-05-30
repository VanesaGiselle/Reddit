//
//  Reddit.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import Foundation

struct NewsResponseFromApi: Codable {
    struct Data: Codable {
        struct Child: Codable {
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
            let data: ChildData
        }
        let children: [Child]
    }
    let data: Data
}
