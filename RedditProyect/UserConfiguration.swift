//
//  UserConfiguration.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 12/04/2023.
//

import UIKit

class UserConfiguration {
    private let alreadyReadNewId = "alreadyReadNewId"
    private let defaults = UserDefaults.standard
    private var readNewsIds: [String] = []
    
    func setReadNew(id: String) {
        var newsIds = readNewsIds
        newsIds.append(id)
        readNewsIds = newsIds
        defaults.set(newsIds, forKey: alreadyReadNewId)
    }
    
    func getNewsId() -> [String] {
        return defaults.array(forKey: alreadyReadNewId) as? [String] ?? []
    }
}
