//
//  NetworkingWeatherProvider.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 30/05/2023.
//

import Foundation

class NetworkingWeatherProvider: WeatherProvider {
    let networking: Networking
    
    init(networking: Networking){
        self.networking = networking
    }
    
    func getWeather(completionHandler: @escaping (Result<Weather, ErrorType>) -> Void, lat: String, lon: String) {
        let appId = "69d2694e3ee76bd71b3c688d7ea1f30b"
        let paths = "data/2.5/weather"
        let queryParams = ["lat": lat, "lon": lon, "appId": appId].compactMapValues({ $0 })
        
        guard let url = URLCreator().createUrl(baseUrl: .weather, queryItems: queryParams, pathEntity: paths) else {
            completionHandler(.failure(.noInternetConnection)) //TODO: Fix error
            return
        }
        
        networking.send(request: Request(url: url, method: .get), parseAs: WeatherResponseFromApi.self) { result in
            switch result {
            case .success(let response):
                let weather = Weather(
                    id: response.id,
                    city: response.name,
                    visibility: response.visibility,
                    title: response.weather.first?.main ?? "",
                    description: response.weather.first?.description ?? "",
                    temp: response.main.temp,
                    feelsLike: response.main.feelsLike,
                    tempMin: response.main.tempMin,
                    tempMax: response.main.tempMax,
                    pressure: response.main.pressure,
                    humidity: response.main.humidity
                )
                completionHandler(.success(weather))
            case .failure(let error):
                completionHandler(.failure(.noInternetConnection)) //TODO: Fix
            }
        }
    }
}
