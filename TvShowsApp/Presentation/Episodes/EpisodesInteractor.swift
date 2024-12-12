//
//  EpisodesInteractor.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol EpisodesInteracting {
    func fetchEpisodes()
    func didSelectEpisode(_ episode: EpisodeDisplayingModel)
}

final class EpisodesInteractor {
    private let service: EpisodesServicing
    private let presenter: EpisodesPresenting
    
    private let id: Int
    
    init(id: Int, service: EpisodesServicing, presenter: EpisodesPresenting) {
        self.service = service
        self.presenter = presenter
        self.id = id
    }
}

extension EpisodesInteractor: EpisodesInteracting {
    func fetchEpisodes() {
        presenter.presentLoading()
        service.fetchEpisodes(with: id) { [weak self] result in
            guard let self = self else { return }
            self.presenter.removeLoading()
            switch result {
            case let .success(episodes):
                self.presenter.present(episodes)
            case .failure:
                self.presenter.presentError()
            }
        }
    }
    
    func didSelectEpisode(_ episode: EpisodeDisplayingModel) {
        presenter.presentEpisodeDetail(episode)
    }
}

