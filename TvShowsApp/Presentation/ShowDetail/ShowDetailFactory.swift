//
//  ShowDetailFactory.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

enum ShowDetailFactory {
    static func make(with id: Int) -> ShowDetailViewController {
        let service: ShowDetailServicing = ShowDetailService()
        let coordinator: ShowDetailCoordinating = ShowDetailCoordinator()
        let presenter: ShowDetailPresenting = ShowDetailPresenter(coordinator: coordinator)
        let interactor = ShowDetailInteractor(id: id, service: service, presenter: presenter)
        let viewController = ShowDetailViewController(interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController

        return viewController
    }
}
