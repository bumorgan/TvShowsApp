//
//  ShowsInteractor.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol ShowsInteracting {
    func fetchShows()
    func cancelSearch()
    func searchShow(with text: String)
    func didSelectShow(with id: Int)
}

final class ShowsInteractor {
    private let service: ShowsServicing
    private let presenter: ShowsPresenting
    
    private var shows = [Show]()
    private var page = 0
    
    private var isSearching = false
    
    init(service: ShowsServicing, presenter: ShowsPresenting) {
        self.service = service
        self.presenter = presenter
    }
}

extension ShowsInteractor: ShowsInteracting {
    func fetchShows() {
        if !isSearching {
            presenter.presentLoading()
            service.fetchShows(of: page) { [weak self] result in
                guard let self = self else { return }
                self.presenter.removeLoading()
                switch result {
                case let .success(shows):
                    self.page += 1
                    self.shows.append(contentsOf: shows)
                    self.presenter.present(self.shows)
                case .failure:
                    self.presenter.presentError()
                }
            }
        }
    }
    
    func searchShow(with text: String) {
        presenter.presentLoading()
        service.fetchSearch(with: text) { [weak self] result in
            guard let self = self else { return }
            self.presenter.removeLoading()
            switch result {
            case let .success(shows):
                self.isSearching = true
                self.presenter.presentSearchResult(shows.map{ $0.show })
            case .failure:
                self.presenter.presentError()
            }
        }
    }
    
    func didSelectShow(with id: Int) {
        presenter.presentShowDetail(id: id)
    }
    
    func cancelSearch() {
        if isSearching {
            isSearching = false
            presenter.present(shows)
        }
    }
}
