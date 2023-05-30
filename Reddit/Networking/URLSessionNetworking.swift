//
//  URLSessionNetworking.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 30/05/2023.
//

import Foundation

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
