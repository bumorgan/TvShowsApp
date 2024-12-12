//
//  Episode.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

struct Episode: Decodable, Equatable {
    let name: String
    let season: Int
    let number: Int
    let summary: String?
    let image: ShowImage?
}
