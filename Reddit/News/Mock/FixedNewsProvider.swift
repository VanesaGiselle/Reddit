//
//  FixedNewsProvider.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 30/04/2023.
//

import Foundation

class FixedNewsProvider: NewsProvider {
    private let news: [New]?
    private let error: ErrorType?
    
    init(news: [New]){
        self.news = news
        self.error = nil
    }
    
    init(error: ErrorType){
        self.error = error
        self.news = nil
    }
    
    func getNews(completionHandler: @escaping (Result<[New], ErrorType>) -> Void, limit: String?) {
        if let news = news {
            completionHandler(.success(news))
        }
        
        if let error = error {
            completionHandler(.failure(error))
        }
    }
}
