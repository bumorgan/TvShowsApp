//
//  EpisodesService.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol EpisodesServicing: Servicing {
    func fetchEpisodes(with id: Int, completion: @escaping ModelCompletionBlock<[Episode]>)
}

final class EpisodesService: EpisodesServicing {
    func fetchEpisodes(with id: Int, completion: @escaping ModelCompletionBlock<[Episode]>) {
        let api = Api<[Episode]>.init(endpoint: Endpoint.episodes(id: id).path)
        api.execute { result in
            completion(result)
        }
    }
}
