//
//  CombineNetworkingPersistenceProvider.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 25/05/2023.
//

import Foundation

class CombineNetworkingPersistenceNewsProvider: NewsProvider {
    private let networking: Networking
    private let newsPersistence: NewsPersistenceConfiguration
    
    init(networking: Networking, newsPersistence: NewsPersistenceConfiguration) {
        self.networking = networking
        self.newsPersistence = newsPersistence
    }
    
    func getNews(completionHandler: @escaping (Result<[New], ErrorType>) -> Void, limit: String?) {
        networking.send(
            request: .init(url: URL(string: "http://www.reddit.com/top.json")!, method: .get),
            parseAs: NewsResponseFromApi.self) { result in
                switch result {
                case .success(let response):
                    let news = response.data.children.map { new in
                        New(id: new.data.id, thumbnail: new.data.thumbnail, title: new.data.title, author: new.data.author, numComments: new.data.numComments)
                    }
                    self.newsPersistence.saveNews(news: news)
                    completionHandler(.success(news))
                case .failure(let error):
                    // TODO: print (error) ?? log?? console??
                    completionHandler(.failure(.noInternetConnection)) // TODO: error??
                }
            }
    }
}
