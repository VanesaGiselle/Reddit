//
//  HttpConnector.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 07/04/2023.
//

import UIKit

//let vc = LoginVC()
//vc.http = HttpConnectorFake()

//LoginVC(

//let networking = ControlledNetworking()
//networking.respondAlways(Response(200, User()))
//let loginVC = LoginVC(networking: HTTP)

class LoginVC: UIViewController {
    //    var networking: Networking!
    //
    //    init()
    //    private let httpConnector = HttpConnector()
    private var networking: Networking
    //    var http2 = HttpConnector(baseUrl: "nueva")
    init(networking: Networking) {
        self.networking = networking
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //    private let networking = RealNetworking()
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        let oldBase = http.baseUrl
        //        http.baseUrl = "nueva"
        //        http.get() {
        //
        //            http.baseUrl = oldBase
        //        }
        
        
        self.networking.send(request: .init(url: URL(string: "server.com/login")!, method: .put), parseAs: LoginJSONResponse.self) { result in
            switch result {
            case .success(let response):
                //                userLoginOk()
                break
            case .failure(let error):
                //                alert.showError()
                break
            }
        }
    }
    
    struct LoginJSONResponse: Decodable {}
}


//class HTTPConnectorNewsProvider: NewsProvider {
//
//    private let httpConnector: HttpConnector
//
//    init(httpConnector: HttpConnector = HttpConnector()) {
//        self.httpConnector = httpConnector
//    }
//
//    func getNews(completionHandler: @escaping(Result<[New], ErrorType>) -> Void, limit: String?) {
//        let queryParams = ["limit": limit].compactMapValues({ $0 })
//
//        let completion = { (result: Result<NewsResponseFromApi, NetworkingError>) in
//
//            switch result {
//            case .success(let newsResponseFromApi):
//                let news: [New] = self.convertApiNewsToUniqueNews(apiNews: newsResponseFromApi)
//                completionHandler(.success(news))
//            case .failure(let error):
//                //To show which is the especific error.
//                debugPrint(error)
//
//                let errorType: ErrorType
//
//                switch error {
//                case .noInternetError:
//                    errorType = .noInternetConnection
//                case .urlError:
//                    errorType = .serverNotFound
//                case .httpError:
//                    errorType = .serverNotFound
//                case .dataError:
//                    errorType = .serverNotFound
//                case .parseError:
//                    errorType = .serverNotFound
//                }
//
//                completionHandler(.failure(errorType))
//            }
//        }
//
//        httpConnector.request(completionHandler: completion, httpMethod: .get, baseUrl: .reddit, queryParamsDict: queryParams, pathEntity: "top.json")
//    }

//    internal func convertApiNewsToUniqueNews(apiNews: NewsResponseFromApi) -> [New] {
//        var news: [New] = []
//        for new in apiNews.data.children {
//            news.append(New(id: new.data.id, thumbnail: new.data.thumbnail, title: new.data.title, author: new.data.author, numComments: new.data.numComments))
//        }
//        return news.getUniqueElements()
//    }
//
//}






//
//    internal func convertNetworkingErrorToErrorType(_ networkingError: NetworkingError) -> ErrorType {
//        //To show which is the especific error.
//        debugPrint(networkingError)
//
//        let errorType: ErrorType
//
//        switch networkingError {
//        case .noInternetError:
//            errorType = .noInternetConnection
//        case .urlError:
//            errorType = .serverNotFound
//        case .httpError:
//            errorType = .serverNotFound
//        case .dataError:
//            errorType = .serverNotFound
//        case .parseError:
//            errorType = .serverNotFound
//        }
//
//        return errorType
//    }

//let networking = NetworkingDouble()
//
//let reqeust = Request("GET", "http://reddit.com/posts")
//networking.respondNextRequestWith(Response(200, "{ alasl:xl0982749y9hio}"))
//networking.send(request, parseAs: NewsJSONResponse.self) { response in
//    switch response {
//    case .success(let response):
//        break
//    case .failure(let error):
//        break
//    }
//}
//
//let reqeust = Request("GET", "api.openweathermap.org/current")
//networking.send(request, parseAs: WeatherJSONResponse.self) { response in
//    switch response {
//    case .success(let response):
//        break
//    case .failure(Error):
//        break
//    }
//
//}
//
//
//func test() {
//    let console = ConsoleViewer()
//    let networking = NetworkingDouble(console: console)
//
//    let reqeust = Request("GET", "hsladkfjhaskjdfh")
//    networking.respondNextRequestWith(Response(200, "{ alasl:xl0982749y9hio}"))
//    networking.send(request, parseAs: NewsJSONResponse.self) { response in
//        switch response {
//        case .success(let response):
//            XCTAssertFail()
//        case .failure(let error):
//            XCTAssert(error === .networkingError)
//        }
//    }
//    XCTAssert(console.lastMessage("Se complico el parseo de JSON: me llego esto: { alasl:xl0982749y9hio}"))
//}

