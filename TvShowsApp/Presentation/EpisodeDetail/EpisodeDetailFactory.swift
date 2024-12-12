//
//  EpisodeDetailFactory.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

enum EpisodeDetailFactory {
    static func make(with episode: EpisodeDisplayingModel) -> EpisodeDetailViewController {
        let presenter: EpisodeDetailPresenting = EpisodeDetailPresenter()
        let interactor = EpisodeDetailInteractor(episode: episode, presenter: presenter)
        let viewController = EpisodeDetailViewController(interactor)
        
        presenter.viewController = viewController

        return viewController
    }
}
