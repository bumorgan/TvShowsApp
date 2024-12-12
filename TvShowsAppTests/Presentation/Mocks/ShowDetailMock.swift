//
//  ShowDetailMock.swift
//  TvShowsAppTests
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

@testable import TvShowsApp

extension ShowDetail {
    static var mock: ShowDetail {
        ShowDetail(id: 1,
                   name: "Breaking Bad",
                   summary: "Summary",
                   genres: ["Drama"],
                   schedule: .mock,
                   image: .mock)
    }
}

extension Schedule {
    static var mock: Schedule {
        Schedule(days: ["Sunday"], time: "21:00")
    }
}
