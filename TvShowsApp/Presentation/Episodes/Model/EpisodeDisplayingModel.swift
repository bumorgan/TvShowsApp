//
//  EpisodeDisplayingModel.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

struct EpisodeDisplayingModel: ItemCellProtocol, Equatable {
    let model: Episode
    
    var title: String {
        "\(model.season)x\(model.number) - \(model.name)"
    }
    
    var imageUrl: URL? {
        guard let url = model.image?.medium else { return nil }
        return URL(string: url)
    }
    
    var summary: String? {
        let summary = model.summary?.removingHtmlTags ?? "-"
        return "Summary: \n\(summary)"
    }
}
