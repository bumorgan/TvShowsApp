//
//  EpisodesPresenter.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol EpisodesPresenting: AnyObject {
    var viewController: EpisodesDisplaying? { get set }
    func presentLoading()
    func removeLoading()
    func presentError()
    func present(_ episodes: [Episode])
    func presentEpisodeDetail(_ episode: EpisodeDisplayingModel)
}

final class EpisodesPresenter {
    weak var viewController: EpisodesDisplaying?
    private let coordinator: EpisodesCoordinating
    
    init(coordinator: EpisodesCoordinating) {
        self.coordinator = coordinator
    }
}

extension EpisodesPresenter: EpisodesPresenting {
    func presentLoading() {
        viewController?.startLoading()
    }
    
    func removeLoading() {
        viewController?.stopLoading()
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    func present(_ episodes: [Episode]) {
        viewController?.display(episodes.map{ EpisodeDisplayingModel(model: $0) })
    }
    
    func presentEpisodeDetail(_ episode: EpisodeDisplayingModel) {
        coordinator.coordinateToEpisodeDetail(with: episode)
    }
}
