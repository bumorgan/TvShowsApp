//
//  ShowDetailCoordinator.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation
import UIKit

protocol ShowDetailCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func coordinateToEpisodes(with id: Int)
}

final class ShowDetailCoordinator {
    weak var viewController: UIViewController?
}

extension ShowDetailCoordinator: ShowDetailCoordinating {
    func coordinateToEpisodes(with id: Int) {
        let controller = EpisodesFactory.make(with: id)
        let navigationController = UINavigationController(rootViewController: controller)
        viewController?.present(navigationController, animated: true)
    }
}
