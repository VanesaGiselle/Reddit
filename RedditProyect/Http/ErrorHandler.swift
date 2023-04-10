//
//  ErrorHandler.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 10/04/2023.
//

import Foundation

enum ErrorHandler: Error {
    case urlError
    case httpError
    case dataError
    case parseError
    case noInternetError
}
