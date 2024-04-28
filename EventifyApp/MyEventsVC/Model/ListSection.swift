//
//  ListSection.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.04.2024.
//

import UIKit

enum ListSection {
    case upcoming([ListItem])
    case recommendations([ListItem])
    case empty

    var items: [ListItem] {
        switch self {
        case .upcoming(let items),
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
        case .upcoming(_):
            return "Предстоящие мероприятия"
        case .recommendations(_):
            return "Рекомендации"
        case .empty:
            return ""
        }
    }
}
