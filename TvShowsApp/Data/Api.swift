//
//  Api.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

enum ApiError: Error {
    case urlParseError
    case decoderError(description: String)
    case nullableData
    case genericError(description: String)
}

final class Api: Servicing {
    static let shared = Api()

    func execute<E: Decodable>(endpoint: String, completion: @escaping ModelCompletionBlock<E>) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let endpoint = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let api = URL(string: endpoint) else {
            return completion(.failure(.urlParseError))
        }

        URLSession.shared.dataTask(with: api) { (data, response, error) in
            if let error = error {
                return completion(.failure(.genericError(description: error.localizedDescription)))
            }
            
            guard let jsonData = data else {
                return completion(.failure(.nullableData))
            }
            
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(E.self, from: jsonData)
                
                completion(.success(decoded))
            } catch let error {
                completion(.failure(.decoderError(description: error.localizedDescription)))
            }
        }.resume()
    }
}
