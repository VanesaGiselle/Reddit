//
//  PersistenceNewsProvider.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 25/05/2023.
//

import Foundation

class NewsPersistenceProvider: NewsProvider {
    let newsPersistence: NewsPersistenceConfiguration
    
    init(newsPersistence: NewsPersistenceConfiguration) {
        self.newsPersistence = newsPersistence
    }
    
    func getNews(completionHandler: @escaping (Result<[New], ErrorType>) -> Void, limit: String?) {
        guard let savedNews = newsPersistence.getNewsFromDefaults() else {
            return
        }
     
        completionHandler(.success(savedNews))
    }
}
