//
//  ShowDetail.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

struct ShowDetail: Decodable, Equatable {
    let id: Int
    let name: String
    let summary: String
    let genres: [String]
    let schedule: Schedule
    let image: ShowImage?
}

struct Schedule: Decodable, Equatable {
    let days: [String]
    let time: String
}
