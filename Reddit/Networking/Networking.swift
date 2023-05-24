//
//  Networking.swift
//  Reddit
//
//  Created by Leandro Linardos on 24/05/2023.
//

import Foundation

struct Request {
    let url: URL // o String
    let method: HttpMethod
    // params ??
}

enum HttpMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

struct Response {
    let statusCode: Int
    let data: Data // o puede ser un json opcional?
}

enum Networking2Error: Swift.Error {
    case error
}

protocol Networking {
    func send<ResponseT: Decodable>(
        request: Request,
        parseAs responseType: ResponseT.Type,
        _ callback: @escaping (Result<ResponseT, Networking2Error>) -> Void
    )
}

//protocol Networking2 {
//    func send<ResponseT: Decodable>(
//        request: Request,
//        _ callback: (Response) -> Void
//    )
//}
//
//networking.send(...) { response.status == 200, JSONDecoder.decode() }


class HTTPConnectorNetworking: Networking {
    private let httpConnector = HttpConnector()
    
    func send<ResponseT>(request: Request, parseAs responseType: ResponseT.Type, _ callback: @escaping (Result<ResponseT, Networking2Error>) -> Void) where ResponseT : Decodable {
        guard let baseURL = request.url.host else {
            return callback(.failure(.error))
        }
        let baseURLCase: BaseUrl
        if baseURL.contains("reddit") {
            baseURLCase = .reddit
        } else if baseURL.contains("openweathermap") {
            baseURLCase = .weather
        } else {
            return callback(.failure(.error))
        }
        httpConnector.request(completionHandler: { (result: Result<ResponseT, NetworkingError>) in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                // print(error) <- console to avoid losing error info?
                callback(.failure(.error))
            }
        }, httpMethod: request.method, baseUrl: baseURLCase, queryParamsDict: nil, pathEntity: request.url.path)
    }
}

class URLSessionNetworking: Networking {
    private let urlSession = URLSession.shared
    
    func send<ResponseT>(request: Request, parseAs responseType: ResponseT.Type, _ callback: @escaping (Result<ResponseT, Networking2Error>) -> Void) where ResponseT : Decodable {
        var urlSessionRequest = URLRequest(url: request.url)
        urlSessionRequest.httpMethod = request.method.rawValue.uppercased()
        urlSession.dataTask(with: urlSessionRequest, completionHandler: { data, response, error in
            DispatchQueue.main.sync {
                if let error = error {
                    // TODO: log or detailed error
                    callback(.failure(.error))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    // TODO: log or detailed error
                    callback(.failure(.error))
                    return
                }
                let response = Response(statusCode: httpResponse.statusCode, data: data ?? Data()) // TODO: ojo con default value
                do {
                    let typedResponse = try JSONDecoder().decode(responseType, from: response.data)
                    callback(.success(typedResponse))
                } catch {
                    // TODO: log or detailed error
                    callback(.failure(.error))
                }
            }
        }).resume()
    }
}
