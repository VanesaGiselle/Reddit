//
//  Pagination.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 01/05/2023.
//

import Foundation

class Pagination {
    private var newsCount = 0
    private let pageSize = 10
    private var pageSizeInclundingCurrentNews: Int {
        pageSize + newsCount
    }
    var newsProvider: NewsProvider?
    var onGotNewsForFirstTime: (()->())?
    
    init() {}

    func getFirstPage(onGotNews: @escaping(Result<[New], ErrorType>) -> Void) {
        newsCount = 0
        getNextPage(onGotNews: { result, addedNews in
            onGotNews(result)
        })
    }
    
    func getNextPage(onGotNews: @escaping(Result<[New], ErrorType>, Int) -> Void) {
        newsProvider?.getNews(completionHandler: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                let addedNews = news.count - self.newsCount
                self.newsCount = news.count
                onGotNews(.success(news), addedNews)
            case .failure(let error):
                onGotNews(.failure(error), 0)
                break
            }
            
        }, limit: String(pageSizeInclundingCurrentNews))
    }
}
