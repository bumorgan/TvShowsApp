//
//  EpisodeDetailInteractor.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol EpisodeDetailInteracting {
    func fetchEpisodeDetail()
}

final class EpisodeDetailInteractor {
    private let presenter: EpisodeDetailPresenting
    
    private let episode: EpisodeDisplayingModel
    
    init(episode: EpisodeDisplayingModel, presenter: EpisodeDetailPresenting) {
        self.presenter = presenter
        self.episode = episode
    }
}

extension EpisodeDetailInteractor: EpisodeDetailInteracting {
    func fetchEpisodeDetail() {
        presenter.present(episode)
    }
}
