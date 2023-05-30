//
//  NewsPersistenceConfiguration.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 25/05/2023.
//

import Foundation

class NewsPersistenceConfiguration {
    private let defaults = UserDefaults.standard
    private let newsKey = "news"
    
    private func convertNewsToNewsPersistence(news: [New]) -> [NewPersistance] {
        var newsPersistence: [NewPersistance] = []
        
        for new in news {
            newsPersistence.append(NewPersistance(id: new.id, thumbnail: new.thumbnail, title: new.title, author: new.author, numComments: new.numComments))
        }
        
       return newsPersistence
    }
    
    private func convertNewsPersistenceToNews(newsPersistence: [NewPersistance]) -> [New] {
        var news: [New] = []
        
        for newsPersistence in newsPersistence {
            news.append(New(id: newsPersistence.id, thumbnail: newsPersistence.thumbnail, title: newsPersistence.title, author: newsPersistence.author, numComments: newsPersistence.numComments))
        }
        
       return news
    }
    
    func saveNews(news: [New]) {
        defaults.set(self.encodeNews(news: convertNewsToNewsPersistence(news: news)), forKey: newsKey)
    }
    
    func getNewsFromDefaults() -> [New]? {
        let newsString = defaults.string(forKey: newsKey)
        guard let newsString = newsString else {
            return nil
        }
        
        guard let newsPersistence = self.decodeNews(json: newsString) else { return nil }
        return convertNewsPersistenceToNews(newsPersistence: newsPersistence)
    }
    
    func encodeNews(news: [NewPersistance]) -> String? {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(news)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            return json
        } catch {
            return nil
        }
    }
    
    func decodeNews(json: String) -> [NewPersistance]? {
        let data = Data(json.utf8)
        let jsonDecoder = JSONDecoder()
        do {
            let news = try jsonDecoder.decode([NewPersistance].self, from: data)
            return news
        } catch {
            return nil
        }
    }
}
