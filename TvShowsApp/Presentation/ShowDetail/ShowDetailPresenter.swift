//
//  ShowDetailPresenter.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol ShowDetailPresenting: AnyObject {
    var viewController: ShowDetailDisplaying? { get set }
    func present(_ show: ShowDetail)
    func presentLoading()
    func removeLoading()
    func presentError()
    func presentEpisodes(with id: Int)
}

final class ShowDetailPresenter {
    weak var viewController: ShowDetailDisplaying?
    private let coordinator: ShowDetailCoordinating
    
    init(coordinator: ShowDetailCoordinating) {
        self.coordinator = coordinator
    }
}

extension ShowDetailPresenter: ShowDetailPresenting {
    func presentLoading() {
        viewController?.startLoading()
    }
    
    func removeLoading() {
        viewController?.stopLoading()
    }
    
    func present(_ show: ShowDetail) {
        let viewModel = ShowDetailDisplayingModel(model: show)
        viewController?.display(viewModel)
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    func presentEpisodes(with id: Int) {
        coordinator.coordinateToEpisodes(with: id)
    }
}
