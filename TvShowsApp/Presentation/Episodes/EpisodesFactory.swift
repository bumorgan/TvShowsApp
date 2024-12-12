//
//  EpisodesFactory.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

enum EpisodesFactory {
    static func make(with id: Int) -> EpisodesViewController {
        let service: EpisodesServicing = EpisodesService()
        let coordinator: EpisodesCoordinating = EpisodesCoordinator()
        let presenter: EpisodesPresenting = EpisodesPresenter(coordinator: coordinator)
        let interactor = EpisodesInteractor(id: id, service: service, presenter: presenter)
        let viewController = EpisodesViewController(interactor)

        presenter.viewController = viewController
        coordinator.viewController = viewController

        return viewController
    }
}
