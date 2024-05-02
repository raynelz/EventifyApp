//
//  AppTabBarItem.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 18.03.2024.
//

import UIKit

enum AppTabBarItem: CaseIterable {
    case main
    case search
    case events
    case favorites
    case profile
    var viewController: UIViewController {
        switch self {
        case .main: return ViewController() // MainViewController
        case .search: return SearchViewController() // SearchViewController
        case .events: return MyActivitiesViewController() // EventsViewController
        case .favorites: return FavoritesViewController() // FavoritesViewController
        case .profile: return ProfileViewController() // ProfileViewController
        }
    }

    var icon: UIImage? {
        switch self {
        case .main:
            return UIImage(systemName: "house")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .events:
            return UIImage(systemName: "bookmark")
        case .favorites:
            return UIImage(systemName: "suit.heart")
        case .profile:
            return UIImage(systemName: "person")
        }
    }

    var title: String {
        switch self {
        case .main:
            return "Главная"
        case .search:
            return "Поиск"
        case .events:
            return "Мои ивенты"
        case .favorites:
            return "Избранное"
        case .profile:
            return "Профиль"
        }
    }
}
