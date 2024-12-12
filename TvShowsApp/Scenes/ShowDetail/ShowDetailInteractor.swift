//
//  ShowDetailInteractor.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol ShowDetailInteracting {
    func fetchShowDetail()
    func didTapEpisodesButton()
}

final class ShowDetailInteractor {
    private let service: ShowDetailServicing
    private let presenter: ShowDetailPresenting
    
    private let id: Int
    
    init(id: Int, service: ShowDetailServicing, presenter: ShowDetailPresenting) {
        self.service = service
        self.presenter = presenter
        self.id = id
    }
}

extension ShowDetailInteractor: ShowDetailInteracting {
    func fetchShowDetail() {
        presenter.presentLoading()
        service.fetchShowDetail(with: id) { [weak self] result in
            guard let self = self else { return }
            self.presenter.removeLoading()
            switch result {
            case let .success(show):
                self.presenter.present(show)
            case .failure:
                self.presenter.presentError()
            }
        }
    }
    
    func didTapEpisodesButton() {
        presenter.presentEpisodes(with: id)
    }
}
