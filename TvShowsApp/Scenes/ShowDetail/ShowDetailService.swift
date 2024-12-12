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
        let api = Api<ShowDetail>.init(endpoint: Endpoint.showDetail(id: id).path)
        api.execute { result in
            completion(result)
        }
    }
}
