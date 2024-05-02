//
//  ProfileSection.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 03.05.2024.
//

import Foundation

enum ProfileSection {
    case item(String, isHasDisclosure: Bool = true)

    var title: String {
        switch self {
        case .item(let title, _):
            return title
        }
    }

    var hasDisclosure: Bool {
        switch self {
        case .item(_, let hasDisclosure):
            return hasDisclosure
        }
    }
}
