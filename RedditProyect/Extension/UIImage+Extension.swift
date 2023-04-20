//
//  UIImage+Extension.swift
//  RedditProyect
//
//  Created by Vanesa Korbenfeld on 10/04/2023.
//

import UIKit

extension UIImageView {
    static func downloaded(from url: String, completionHandlerSuccess: @escaping (UIImage) -> (), completionHandlerFailure: @escaping () -> ()) {
        guard let url = URL(string: url) else {
            DispatchQueue.main.async() {
                completionHandlerFailure()
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async() {
                    completionHandlerFailure()
                }
                return
            }
            DispatchQueue.main.async() {
                completionHandlerSuccess(image)
            }
        }.resume()
    }
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill, completionHandler: ((UIImage) -> ())?, failure: (() -> ())? = nil) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                DispatchQueue.main.async {
                    if let failure = failure {
                        failure()
                    }
                }
                return
            }
            DispatchQueue.main.async() { [weak self] in
                if let completionHandler = completionHandler {
                    completionHandler(image)
                    return
                }
                
                UIImageView.transition(with: self ?? UIImageView(), duration: 0.5, options: [.curveEaseOut, .transitionCrossDissolve], animations: {
                    self?.image = image
                })
            }
        }.resume()
    }
    
    func download(from link: String, contentMode mode: ContentMode = .scaleAspectFill, completionHandler: ((UIImage) -> ())? = nil, failure: (() -> ())? = nil) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode, completionHandler: completionHandler, failure: failure)
    }
}
