//
//  Error.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 10/04/2023.
//

import Foundation

enum ErrorType: Error {
    case urlError
    case httpError
    case dataError
    case parseError
    case noInternetError
    
    func getErrorManagerViewModel() -> ErrorManager.ViewModel {
        var title: String
        var actionMessage: String
        
        switch self {
        case .urlError:
            title = "The URL is unavailable."
            actionMessage = "Please, try later."
        case .httpError:
            title = "Error in server."
            actionMessage = "Please, try later."
        case .dataError:
            title = "The data is unavailable."
            actionMessage = "Please, try later."
        case .parseError:
            title = "The information is invalid."
            actionMessage = "Please, try later."
        case .noInternetError:
            title = "No internet connection."
            actionMessage = "Please, check and try again."
        }
        return ErrorManager.ViewModel(title: title, actionMessage: actionMessage)
    }
}
