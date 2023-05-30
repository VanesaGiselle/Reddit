//
//  AlamofireNetworking.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 30/05/2023.
//

import Alamofire
import Foundation

class AlamofireNetworking: Networking {
    func send<ResponseT>(request: Request, parseAs responseType: ResponseT.Type, _ callback: @escaping (Result<ResponseT, Networking2Error>) -> Void) where ResponseT : Decodable {
        
        let method = HTTPMethod(rawValue: request.method.rawValue)
        
        print("URL: \(request.url)")
        print("METHOD: \(method)")
        
        AF.request(request.url, method: method).responseDecodable(of: ResponseT.self) { response in
            switch response.result {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(.error))
            }
        }
    }
}
