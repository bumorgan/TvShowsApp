//
//  ShowsCoordinator.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation
import UIKit

protocol ShowsCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func coordinateToShowDetail(with id: Int)
}

final class ShowsCoordinator {
    weak var viewController: UIViewController?
}

extension ShowsCoordinator: ShowsCoordinating {
    func coordinateToShowDetail(with id: Int) {
        let controller = ShowDetailFactory.make(with: id)
        viewController?.show(controller, sender: self)
    }
}
