//
//  ShowDetailDisplayingModel.swift
//  TvShowsApp
//
//  Created by Bruno de Mello Morgan on 12/12/24.
//

import Foundation
import UIKit

struct ShowDetailDisplayingModel: Equatable {
    let model: ShowDetail
    
    var title: String {
        model.name
    }
    
    var imageUrl: URL? {
        guard let url = model.image?.medium else { return nil }
        return URL(string: url)
    }
    
    var schedule: String {
        "Schedule: \n\(model.schedule.days.joined(separator: ", ")) - \(model.schedule.time)"
    }
    
    var summary: String {
        "Summary: \n\(model.summary.removingHtmlTags)"
    }
    
    var genres: String {
        "Genres: \n\(model.genres.joined(separator: ", "))"
    }
}
