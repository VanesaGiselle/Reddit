//
//  UIViewController+Extension.swift
//  Reddit
//
//  Created by Vanesa Korbenfeld on 18/04/2023.
//

import UIKit

extension UIViewController {
    func handleFailure(_ error: ErrorType) {
        let errorViewController = ErrorManager(viewModel: error.getErrorManagerViewModel()).getErrorViewController(error: error)
        self.present(errorViewController, animated: false)
    }
}
