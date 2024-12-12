//
//  ShowsService.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol ShowsServicing: Servicing {
    func fetchShows(of page: Int, completion: @escaping ModelCompletionBlock<[Show]>)
    func fetchSearch(with text: String, completion: @escaping ModelCompletionBlock<[SearchResult]>)
}

final class ShowsService: ShowsServicing {
    func fetchShows(of page: Int, completion: @escaping ModelCompletionBlock<[Show]>) {
        let api = Api<[Show]>.init(endpoint: Endpoint.shows(page: page).path)
        api.execute { result in
            completion(result)
        }
    }
    
    func fetchSearch(with text: String, completion: @escaping ModelCompletionBlock<[SearchResult]>) {
        let api = Api<[SearchResult]>.init(endpoint: Endpoint.searchShow(text: text).path)
        api.execute { result in
            completion(result)
        }
    }
}
