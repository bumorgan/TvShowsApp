//
//  ShowsInteractorTests.swift
//  TvShowsAppTests
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import XCTest
@testable import TvShowsApp

private final class ShowsServiceMock: ShowsServicing {
    var fetchShowsExpectedResult: Result<[Show], ApiError>?
    var fetchSearchExpectedResult: Result<[SearchResult], ApiError>?
    
    
    func fetchShows(of page: Int, completion: @escaping ModelCompletionBlock<[Show]>) {
        guard let expectedResult = fetchShowsExpectedResult else { return }
        completion(expectedResult)
    }
    
    func fetchSearch(with text: String, completion: @escaping ModelCompletionBlock<[SearchResult]>) {
        guard let expectedResult = fetchSearchExpectedResult else { return }
        completion(expectedResult)
    }
}

private final class ShowsPresenterSpy: ShowsPresenting {
    var viewController: ShowsDisplaying?
    
    private(set) var callPresentCount = 0
    private(set) var callPresentSearchResultCount = 0
    private(set) var callPresentLoadingCount = 0
    private(set) var callPresentErrorCount = 0
    private(set) var callRemoveLoadingCount = 0
    private(set) var callPresentShowDetailCount = 0
    
    private(set) var presentedShows: [Show]?
    private(set) var searchedShows: [Show]?
    private(set) var showDetailId: Int?
    
    func present(_ shows: [Show]) {
        callPresentCount += 1
        presentedShows = shows
    }
    
    func presentSearchResult(_ shows: [Show]) {
        callPresentSearchResultCount += 1
        searchedShows = shows
    }
    
    func presentShowDetail(id: Int) {
        callPresentShowDetailCount += 1
        showDetailId = id
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
}

final class ShowsInteractorTests: XCTestCase {
    private lazy var presenterSpy = ShowsPresenterSpy()
    private lazy var serviceMock = ShowsServiceMock()
    
    private lazy var sut = ShowsInteractor(service: serviceMock, presenter: presenterSpy)
    
    func testFetchShows_ShouldPresentShows() throws {
        let expectedShows = [Show.mock]
        serviceMock.fetchShowsExpectedResult = .success(expectedShows)

        sut.fetchShows()

        XCTAssertEqual(presenterSpy.callPresentLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callRemoveLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callPresentCount, 1)
        XCTAssertEqual(presenterSpy.presentedShows, expectedShows)
    }
    
    func testFetchShows_WhenFailure_ShouldPresentError() throws {
        serviceMock.fetchShowsExpectedResult = .failure(.nullableData)

        sut.fetchShows()

        XCTAssertEqual(presenterSpy.callPresentLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callRemoveLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callPresentErrorCount, 1)
    }
    
    func testFetchSearch_ShouldPresentSearchResult() throws {
        let expectedSearchResult = [SearchResult.mock]
        serviceMock.fetchSearchExpectedResult = .success(expectedSearchResult)

        sut.searchShow(with: "Breaking Bad")

        XCTAssertEqual(presenterSpy.callPresentLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callRemoveLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callPresentSearchResultCount, 1)
        XCTAssertEqual(presenterSpy.searchedShows, expectedSearchResult.map{ $0.show })
    }
    
    func testFetchSearch_WhenFailure_ShouldPresentError() throws {
        serviceMock.fetchSearchExpectedResult = .failure(.nullableData)

        sut.searchShow(with: "Breaking Bad")

        XCTAssertEqual(presenterSpy.callPresentLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callRemoveLoadingCount, 1)
        XCTAssertEqual(presenterSpy.callPresentErrorCount, 1)
    }
    
    func testDidSelect_ShouldPresentShowDetail() throws {
        let selectedId = 1
        sut.didSelectShow(with: selectedId)

        XCTAssertEqual(presenterSpy.callPresentShowDetailCount, 1)
        XCTAssertEqual(presenterSpy.showDetailId, selectedId)
    }
    
    func testCancelSearch_WhenIsSearching_ShouldPresentShows() throws {
        let expectedSearchResult = [SearchResult.mock]
        serviceMock.fetchSearchExpectedResult = .success(expectedSearchResult)
        
        sut.searchShow(with: "Breaking Bad")
        sut.cancelSearch()

        XCTAssertEqual(presenterSpy.callPresentCount, 1)
    }
    
    func testCancelSearch_WhenIsNotSearching() throws {
        sut.cancelSearch()

        XCTAssertEqual(presenterSpy.callPresentCount, 0)
    }
}
