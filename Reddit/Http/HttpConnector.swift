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

// TODO: Agarrar los datos de user default. Llamar UserDefaultNewsProvider.
class HTTPConnectorNewsProvider: NewsProvider {
    
    private let httpConnector: HttpConnector
    
    init(httpConnector: HttpConnector = HttpConnector()) {
        self.httpConnector = httpConnector
    }
    
    func getNews(completionHandler: @escaping(Result<[New], ErrorType>) -> Void, limit: String?) {
        let queryParams = ["limit": limit].compactMapValues({ $0 })
        
        let completion = { (result: Result<NewsResponseFromApi, NetworkingError>) in
            
            switch result {
            case .success(let newsResponseFromApi):
                let news: [New] = self.convertApiNewsToUniqueNews(apiNews: newsResponseFromApi)
                completionHandler(.success(news))
            case .failure(let error):
                //To show which is the especific error.
                debugPrint(error)
                
                let errorType: ErrorType
                
                switch error {
                case .noInternetError:
                    errorType = .noInternetConnection
                case .urlError:
                    errorType = .serverNotFound
                case .httpError:
                    errorType = .serverNotFound
                case .dataError:
                    errorType = .serverNotFound
                case .parseError:
                    errorType = .serverNotFound
                }
                
                completionHandler(.failure(errorType))
            }
        }
        
        httpConnector.request(completionHandler: completion, httpMethod: .get, baseUrl: .reddit, queryParamsDict: queryParams, pathEntity: "top.json")
    }
    
    internal func convertApiNewsToUniqueNews(apiNews: NewsResponseFromApi) -> [New] {
        var news: [New] = []
        for new in apiNews.data.children {
            news.append(New(id: new.data.id, thumbnail: new.data.thumbnail, title: new.data.title, author: new.data.author, numComments: new.data.numComments))
        }
        return news.getUniqueElements()
    }
    
}

class NetworkingNewsProvider: NewsProvider {
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
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
                    completionHandler(.success(news))
                case .failure(let error):
                    // TODO: print (error) ?? log?? console??
                    completionHandler(.failure(.noInternetConnection)) // TODO: error??
                }
            }
    }
}

class HttpConnector: WeatherProvider {
    enum Method: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    private func createComponents(baseUrl: BaseUrl) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseUrl.rawValue
        return components
    }
    
    private func createUrl(baseUrl: BaseUrl, queryItems: [String: String]?, pathEntity: String) -> URL? {
        var components = createComponents(baseUrl: baseUrl)
        components.path = "/\(pathEntity)"
        
        guard let queryItems = queryItems else {
            return components.url
        }
        
        let querys = queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = querys
        return components.url
    }
    
    func request<T: Decodable>(completionHandler: @escaping(Result<T, NetworkingError>) -> Void, httpMethod: HttpMethod, baseUrl: BaseUrl, queryParamsDict: [String: String]?, pathEntity: String) {
        
        guard let url = createUrl(baseUrl: baseUrl, queryItems: queryParamsDict, pathEntity: pathEntity) else {
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
    
    func getWeather(completionHandler: @escaping(Result<Weather, ErrorType>) -> Void, lat: String, lon: String) {
        let appId = "69d2694e3ee76bd71b3c688d7ea1f30b"
        let paths = "data/2.5/weather"
        let queryParams = ["lat": lat, "lon": lon, "appId": appId].compactMapValues({ $0 })
        
        let completion = { (result: Result<WeatherResponseFromApi, NetworkingError>) in
            
            switch result {
            case .success(let weatherResponseFromApi):
                let weather: Weather = self.convertWeatherResponseFromApiToWeather(weatherResponseFromApi)
                completionHandler(.success(weather))
            case .failure(let error):
                completionHandler(.failure(self.convertNetworkingErrorToErrorType(error)))
            }
        }
        
        self.request(completionHandler: completion, httpMethod: .get, baseUrl: .weather, queryParamsDict: queryParams, pathEntity: paths)

    }
    
    internal func convertWeatherResponseFromApiToWeather(_ weatherResponse: WeatherResponseFromApi) -> Weather {
       
        return Weather(id: weatherResponse.id,
                       city: weatherResponse.name,
                       visibility: weatherResponse.visibility,
                       title: weatherResponse.weather.first?.main ?? "",
                       description: weatherResponse.weather.first?.description ?? "",
                       temp: weatherResponse.main.temp,
                       feelsLike: weatherResponse.main.feelsLike,
                       tempMin: weatherResponse.main.tempMin,
                       tempMax: weatherResponse.main.tempMax,
                       pressure: weatherResponse.main.pressure,
                       humidity: weatherResponse.main.humidity
        )
    }
    
    internal func convertNetworkingErrorToErrorType(_ networkingError: NetworkingError) -> ErrorType {
        //To show which is the especific error.
        debugPrint(networkingError)
        
        let errorType: ErrorType
        
        switch networkingError {
        case .noInternetError:
            errorType = .noInternetConnection
        case .urlError:
            errorType = .serverNotFound
        case .httpError:
            errorType = .serverNotFound
        case .dataError:
            errorType = .serverNotFound
        case .parseError:
            errorType = .serverNotFound
        }
        
        return errorType
    }
}

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

