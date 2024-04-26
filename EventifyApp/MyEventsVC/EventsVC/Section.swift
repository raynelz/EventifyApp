//
//  EventsItem.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.03.2024.
//

import Foundation

enum Section {
    case upcoming([EventsModel])
    case wait([EventsModel])

    var items: [EventsModel] {
        switch self {
        case .upcoming(let items), .wait(let items): return items
        }
    }
}
