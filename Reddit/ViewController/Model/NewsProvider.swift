//
//  NewsProvider.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 30/04/2023.
//

import Foundation

protocol NewsProvider {
    func getNews(completionHandler: @escaping(Result<[New], ErrorType>) -> Void, limit: String?)
}
