//
//  Endpoint.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

enum Endpoint {
    case shows(page: Int)
    case searchShow(text: String)
    case showDetail(id: Int)
    case episodes(id: Int)
}

extension Endpoint {
    var path: String {
        switch self {
        case let .shows(page):
            return "https://api.tvmaze.com/shows?page=\(page)"
        case let .searchShow(search):
            return "https://api.tvmaze.com/search/shows?q=\(search)"
        case let .showDetail(id):
            return "https://api.tvmaze.com/shows/\(id)"
        case let .episodes(id):
            return "https://api.tvmaze.com/shows/\(id)/episodes"
        }
    }
}
