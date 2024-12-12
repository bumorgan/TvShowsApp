//
//  ShowDetailInteractorTests.swift
//  TvShowsAppTests
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import XCTest
@testable import TvShowsApp

private final class ShowDetailServiceMock: ShowDetailServicing {
    var fetchShowDetailExpectedResult: Result<ShowDetail, ApiError>?
    
    func fetchShowDetail(with id: Int, completion: @escaping ModelCompletionBlock<ShowDetail>) {
        guard let expectedResult = fetchShowDetailExpectedResult else { return }
        completion(expectedResult)
    }
}

private final class ShowDetailPresenterSpy: ShowDetailPresenting {
    var viewController: ShowDetailDisplaying?
    
    private(set) var callPresentLoadingCount = 0
    private(set) var callPresentErrorCount = 0
    private(set) var callRemoveLoadingCount = 0
    private(set) var callPresentShowDetailCount = 0
    private(set) var callPresentEpisodesCount = 0
    
    private(set) var showDetail: ShowDetail?
    
    func present(_ show: ShowDetail) {
        showDetail = show
        callPresentShowDetailCount += 1
    }
    
    func presentLoading() {
        callPresentLoadingCount += 1
    }
    
    func removeLoading() {
        callRemoveLoadingCount += 1
    }
    
    func presentError() {
        callPresentErrorCount += 1
    }
    
    func presentEpisodes(with id: Int) {
        callPresentEpisodesCount += 1
    }
}

final class ShowDetailInteractorTests: XCTestCase {
    private lazy var presenterSpy = ShowDetailPresenterSpy()
    private lazy var serviceMock = ShowDetailServiceMock()
    
    private lazy var sut = ShowDetailInteractor(id: 1, service: serviceMock, presenter: presenterSpy)
    
    func testFetchShowDetail_ShouldPresentShowDetail() throws {
        let expectedShowDetail = ShowDetail.mock
        serviceMock.fetchShowDetailExpectedResult = .success(expectedShowDetail)

        sut.fetchShowDetail()

        XCTAssertEqual(presenterSpy.callPresentLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callRemoveLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callPresentShowDetailCount, 1)
        XCTAssertEqual(presenterSpy.showDetail, expectedShowDetail)
    }
    
    func testFetchShowDetail_WhenFailure_ShouldPresentError() throws {
        serviceMock.fetchShowDetailExpectedResult = .failure(.nullableData)

        sut.fetchShowDetail()

        XCTAssertEqual(presenterSpy.callPresentLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callRemoveLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callPresentErrorCount, 1)
    }
    
    func testDidTapEpisodesButton_ShouldPresentEpisodes() throws {
        sut.didTapEpisodesButton()

        XCTAssertEqual(presenterSpy.callPresentEpisodesCount, 1)
    }
}
