//
//  ShowDetailService.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol ShowDetailServicing: Servicing {
    func fetchShowDetail(with id: Int, completion: @escaping ModelCompletionBlock<ShowDetail>)
}

final class ShowDetailService: ShowDetailServicing {
    func fetchShowDetail(with id: Int, completion: @escaping ModelCompletionBlock<ShowDetail>) {
        Api.shared.execute(endpoint: Endpoint.showDetail(id: id).path) { result in
            completion(result)
        }
    }
}
