//
//  Servicing.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

protocol Servicing {
    typealias ModelCompletionBlock<T: Decodable> = (Result<T, ApiError>) -> Void
}
