//
//  ShowMock.swift
//  TvShowsAppTests
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

@testable import TvShowsApp

extension Show {
    static var mock: Show {
        Show(id: 1, name: "Breaking Bad", image: .mock)
    }
}

extension ShowImage {
    static var mock: ShowImage {
        ShowImage(medium: "")
    }
}
