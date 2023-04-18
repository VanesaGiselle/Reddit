//
//  Array+Extension.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 17/04/2023.
//

import Foundation

extension Array {
    func getUniqueElements<T: Equatable>() -> [T] {
        var unique = [T]()
        for element in self {
            if !unique.contains(where: {$0 == element as? T }) {
                guard let element = element as? T else { continue }
                unique.append(element)
            }
        }
        return unique
    }
}
