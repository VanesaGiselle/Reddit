//
//  HttpConnector.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

class HttpConnector: NewsProvider {
    private func createComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "reddit.com"
        return components
    }
    
    private func createUrl(queryItems: [String: String]?, pathEntity: String) -> URL? {
        var components = createComponents()
        components.path = "/\(pathEntity)"
        
        guard let queryItems = queryItems else {
            return components.url
        }
        
        let querys = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = querys
        return components.url
    }
    
    private func request<T: Decodable>(completionHandler: @escaping(Result<T, ErrorType>) -> Void, httpMethod: HttpMethod, queryParamsDict: [String: String]?, pathEntity: String) {
        
        guard let url = createUrl(queryItems: queryParamsDict, pathEntity: pathEntity) else {
            DispatchQueue.main.async {
                completionHandler(.failure(.urlError))
            }
            return
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        print("Endpoint: \(url.absoluteString)")
        request.httpMethod = httpMethod.rawValue
        
        let dataTask = session.dataTask(with: request) { (data, response, errorResponse) in
            
            if errorResponse == nil {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.dataError))
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.dataError))
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                print("Status code: \(httpResponse.statusCode)")
                let responseBody = String(decoding: data, as: UTF8.self)
                print("Response body: \(responseBody)")
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let entity = try decoder.decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completionHandler(.success(entity))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completionHandler(.failure(.parseError))
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        completionHandler(.failure(.dataError))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noInternetError))
                }
            }
        }
        dataTask.resume()
    }
    
    //MARK: - GET
    
    func getNews(completionHandler: @escaping(Result<News, ErrorType>) -> Void, limit: String?) {
        let queryParams = ["limit": limit].compactMapValues({ $0 })
        self.request(completionHandler: completionHandler, httpMethod: .get, queryParamsDict: queryParams, pathEntity: "top.json")
    }
}

