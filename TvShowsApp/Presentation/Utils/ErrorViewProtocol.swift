//
//  ErrorViewProtocol.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation
import UIKit

public protocol ErrorViewProtocol {
    func displayError(title: String, message: String, buttonTitle: String, buttonAction: @escaping () -> Void)
}

public extension ErrorViewProtocol where Self: UIViewController {
    func displayError(title: String = "Error", message: String = "Something went wrong", buttonTitle: String = "Try again", buttonAction: @escaping () -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) { _ in
                buttonAction()
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
