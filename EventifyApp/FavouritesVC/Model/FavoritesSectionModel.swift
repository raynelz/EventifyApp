//
//  FavoritesSectionModel.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//

import UIKit

enum FavoritesSectionModel {
    case favorites([FavoritesModel])
    case recommendations([FavoritesModel])
    case empty

    var items: [FavoritesModel] {
        switch self {
        case .favorites(let items),
                .recommendations(let items):
            return items
        case .empty: return []
        }
    }

    var count: Int {
        items.count
    }

    var title: String {
        switch self {
        case .favorites(_):
            return ""
        case .recommendations(_): 
            return "Рекомендации"
        case .empty:
            return ""
        }
    }
}
