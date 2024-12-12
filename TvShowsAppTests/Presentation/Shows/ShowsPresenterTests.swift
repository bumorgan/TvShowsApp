//
//  ShowsPresenterTests.swift
//  TvShowsAppTests
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import XCTest
@testable import TvShowsApp

private final class ShowsDisplaySpy: ShowsDisplaying {
    private(set) var callStartLoadingCount = 0
    private(set) var callStopLoadingCount = 0
    private(set) var callDisplayShowsCount = 0
    private(set) var callDisplaySearchResultCount = 0
    private(set) var callDisplayErrorCount = 0
    
    private(set) var displayedShows: [ShowDisplayingModel]?
    
    func display(_ shows: [ShowDisplayingModel]) {
        callDisplayShowsCount += 1
        displayedShows = shows
    }
    
    func displaySearchResult(_ shows: [ShowDisplayingModel]) {
        callDisplaySearchResultCount += 1
        displayedShows = shows
    }
    
    func startLoading() {
        callStartLoadingCount += 1
    }
    
    func stopLoading() {
        callStopLoadingCount += 1
    }
    
    func displayError() {
        callDisplayErrorCount += 1
    }
}

private final class ShowsCoordinatorSpy: ShowsCoordinating {
    weak var viewController: UIViewController?
    
    private(set) var callCoordinateToShowDetailCount = 0
    private(set) var showDetailId: Int?
    
    func coordinateToShowDetail(with id: Int) {
        callCoordinateToShowDetailCount += 1
        showDetailId = id
    }
}

final class ShowsPresenterTests: XCTestCase {
    private lazy var viewControllerSpy = ShowsDisplaySpy()
    private lazy var coordinatorSpy = ShowsCoordinatorSpy()
    private lazy var sut: ShowsPresenter = {
        let presenter = ShowsPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func testPresentLoading_ShouldCallStartLoading() {
        sut.presentLoading()

        XCTAssertEqual(viewControllerSpy.callStartLoadingCount, 1)
    }
    
    func testRemoveLoading_ShouldCallStopLoading() {
        sut.removeLoading()

        XCTAssertEqual(viewControllerSpy.callStopLoadingCount, 1)
    }

    func testPresentShows_ShouldCallDisplayShows() {
        let shows = [Show.mock]
        sut.present(shows)

        XCTAssertEqual(viewControllerSpy.callDisplayShowsCount, 1)
        XCTAssertEqual(viewControllerSpy.displayedShows, shows.map{ ShowDisplayingModel(model: $0) })
    }
    
    func testPresentSearchResult_ShouldCallDisplaySearchResult() {
        let shows = [Show.mock]
        sut.presentSearchResult(shows)

        XCTAssertEqual(viewControllerSpy.callDisplaySearchResultCount, 1)
        XCTAssertEqual(viewControllerSpy.displayedShows, shows.map{ ShowDisplayingModel(model: $0) })
    }
    
    func testPresentShowDetail_ShouldCoordinateToShowDetail() {
        let showId = 1
        sut.presentShowDetail(id: showId)

        XCTAssertEqual(coordinatorSpy.callCoordinateToShowDetailCount, 1)
        XCTAssertEqual(coordinatorSpy.showDetailId, showId)
    }
    
    func testPresentError_ShouldDisplayError() {
        sut.presentError()

        XCTAssertEqual(viewControllerSpy.callDisplayErrorCount, 1)
    }
}
