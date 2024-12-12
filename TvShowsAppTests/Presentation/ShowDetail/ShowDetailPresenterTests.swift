//
//  ShowDetailPresenterTests.swift
//  TvShowsAppTests
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import XCTest
@testable import TvShowsApp

private final class ShowDetailDisplaySpy: ShowDetailDisplaying {
    private(set) var callStartLoadingCount = 0
    private(set) var callStopLoadingCount = 0
    private(set) var callDisplayShowDetailCount = 0
    private(set) var callDisplayErrorCount = 0
    
    private(set) var showDetail: ShowDetailDisplayingModel?
    
    
    func display(_ show: ShowDetailDisplayingModel) {
        callDisplayShowDetailCount += 1
        showDetail = show
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

private final class ShowDetailCoordinatorSpy: ShowDetailCoordinating {
    weak var viewController: UIViewController?
    private(set) var callCoordinateToEpisodesCount = 0
    
    private(set) var id: Int?
    
    func coordinateToEpisodes(with id: Int) {
        callCoordinateToEpisodesCount += 1
        self.id = id
    }
}

final class ShowDetailPresenterTests: XCTestCase {
    private lazy var viewControllerSpy = ShowDetailDisplaySpy()
    private lazy var coordinatorSpy = ShowDetailCoordinatorSpy()
    private lazy var sut: ShowDetailPresenter = {
        let presenter = ShowDetailPresenter(coordinator: coordinatorSpy)
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
    
    func testPresentError_ShouldDisplayError() {
        sut.presentError()

        XCTAssertEqual(viewControllerSpy.callDisplayErrorCount, 1)
    }
    
    func testPresentShowDetail_ShouldCallDisplayShowDetail() {
        sut.present(.mock)
        
        XCTAssertEqual(viewControllerSpy.callDisplayShowDetailCount, 1)
        XCTAssertEqual(viewControllerSpy.showDetail, ShowDetailDisplayingModel(model: .mock))
    }
    
    func testPresentEpisodes_ShouldCoordinateToEpisodes() {
        let id = 1
        sut.presentEpisodes(with: id)

        XCTAssertEqual(coordinatorSpy.callCoordinateToEpisodesCount, 1)
        XCTAssertEqual(coordinatorSpy.id, id)
    }
}
