//
//  ShowDisplayingModel.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation

struct ShowDisplayingModel: ItemCellProtocol, Equatable {
    let model: Show
    
    var id: Int {
        model.id
    }
    
    var title: String {
        model.name
    }
    
    var imageUrl: URL? {
        guard let url = model.image?.medium else { return nil }
        return URL(string: url)
    }
}
