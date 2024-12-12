//
//  Show.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

struct Show: Decodable, Equatable {
    let id: Int
    let name: String
    let image: ShowImage?
}

struct ShowImage: Decodable, Equatable {
    let medium: String
}
