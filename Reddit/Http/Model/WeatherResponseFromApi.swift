//
//  WeatherResponseFromApi.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 08/05/2023.
//

import Foundation

struct WeatherResponseFromApi: Codable {
    let id: Int
    let name: String
    let weather: [WeatherData]
    let main: Main
    let visibility: Int
    
    struct WeatherData: Codable {
        let main: String
        let description: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int

        private enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
        }
    }
}
