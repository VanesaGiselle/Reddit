//
//  FixedWeatherProvider.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 09/05/2023.
//

import Foundation

class FixedWeatherProvider: WeatherProvider {
    private let weather: Weather?
    private let error: ErrorType?
    
    init(weather: Weather){
        self.weather = weather
        self.error = nil
    }
    
    init(error: ErrorType){
        self.error = error
        self.weather = nil
    }
    
    func getWeather(completionHandler: @escaping (Result<Weather, ErrorType>) -> Void, lat lon: String, lon lat: String) {
        if let weather = weather {
            completionHandler(.success(weather))
        }
        
        if let error = error {
            completionHandler(.failure(error))
        }
    }
}
