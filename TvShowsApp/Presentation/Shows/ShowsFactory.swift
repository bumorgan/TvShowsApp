//
//  ShowsFactory.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

enum ShowsFactory {
    static func make() -> ShowsViewController {
        let service: ShowsServicing = ShowsService()
        let coordinator: ShowsCoordinating = ShowsCoordinator()
        let presenter: ShowsPresenting = ShowsPresenter(coordinator: coordinator)
        let interactor = ShowsInteractor(service: service, presenter: presenter)
        let viewController = ShowsViewController(interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController

        return viewController
    }
}
