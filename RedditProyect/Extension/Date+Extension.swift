//
//  Date+Extension.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 11/04/2023.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-m-d HH:mm:ss"
        return formatter.string(from: self)
    }
}
