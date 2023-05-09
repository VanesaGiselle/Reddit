//
//  WeatherProvider.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 08/05/2023.
//

import Foundation

protocol WeatherProvider {
    func getWeather(completionHandler: @escaping(Result<Weather, ErrorType>) -> Void, lat: String, lon: String)
}

