//
//  ShowsPresenter.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol ShowsPresenting: AnyObject {
    var viewController: ShowsDisplaying? { get set }
    func present(_ shows: [Show])
    func presentSearchResult(_ shows: [Show])
    func presentShowDetail(id: Int)
    func presentLoading()
    func removeLoading()
    func presentError()
}

final class ShowsPresenter {
    private let coordinator: ShowsCoordinating
    weak var viewController: ShowsDisplaying?
    
    init(coordinator: ShowsCoordinating) {
        self.coordinator = coordinator
    }
}

extension ShowsPresenter: ShowsPresenting {
    func present(_ shows: [Show]) {
        let viewModel = shows.map { ShowDisplayingModel(model: $0) }
        viewController?.display(viewModel)
    }
    
    func presentSearchResult(_ shows: [Show]) {
        let viewModel = shows.map { ShowDisplayingModel(model: $0) }
        viewController?.displaySearchResult(viewModel)
    }
    
    func presentLoading() {
        viewController?.startLoading()
    }
    
    func removeLoading() {
        viewController?.stopLoading()
    }
    
    func presentShowDetail(id: Int) {
        coordinator.coordinateToShowDetail(with: id)
    }
    
    func presentError() {
        viewController?.displayError()
    }
}
