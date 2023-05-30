//
//  CreateURL.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 30/05/2023.
//

import Foundation

class URLCreator {
    private func createComponents(baseUrl: BaseUrl) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseUrl.rawValue
        return components
    }
    
    func createUrl(baseUrl: BaseUrl, queryItems: [String: String]?, pathEntity: String) -> URL? {
        var components = createComponents(baseUrl: baseUrl)
        components.path = "/\(pathEntity)"
        
        guard let queryItems = queryItems else {
            return components.url
        }
        
        let querys = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = querys
        return components.url
    }
}
