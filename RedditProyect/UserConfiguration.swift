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
    
    func setReadNew(id: String) {
        var newsIds = getNewsId()
        newsIds.append(id)
        defaults.set(newsIds, forKey: alreadyReadNewId)
    }
    
    func getNewsId() -> [String] {
        return defaults.array(forKey: alreadyReadNewId) as? [String] ?? []
    }
}
