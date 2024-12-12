//
//  EpisodesCoordinator.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation
import UIKit

protocol EpisodesCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func coordinateToEpisodeDetail(with episode: EpisodeDisplayingModel)
}

final class EpisodesCoordinator {
    weak var viewController: UIViewController?
}

extension EpisodesCoordinator: EpisodesCoordinating {
    func coordinateToEpisodeDetail(with episode: EpisodeDisplayingModel) {
        let controller = EpisodeDetailFactory.make(with: episode)
        viewController?.show(controller, sender: self)
    }
}
