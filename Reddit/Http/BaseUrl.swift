//
//  BaseUrl.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 05/05/2023.
//

import Foundation

struct BaseUrl {
    var rawValue: String
    
    static let reddit = BaseUrl(rawValue: "reddit.com")
    static let weather = BaseUrl(rawValue: "api.openweathermap.org")
}
