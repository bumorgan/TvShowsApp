//
//  EpisodeDetailPresenter.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol EpisodeDetailPresenting: AnyObject {
    var viewController: EpisodeDetailDisplaying? { get set }
    func present(_ episode: EpisodeDisplayingModel)
}

final class EpisodeDetailPresenter {
    weak var viewController: EpisodeDetailDisplaying?
}

extension EpisodeDetailPresenter: EpisodeDetailPresenting {
    func present(_ episode: EpisodeDisplayingModel) {
        viewController?.display(episode)
    }
}
