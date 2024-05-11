//
//  FavoritesOrganizersMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//
import UIKit

struct FavoritesOrganizersMockData {
    static let shared = FavoritesOrganizersMockData()

    private let favorites: FavoritesSectionModel = {
        .favorites(
            [
                .init(
                    name: "ITAM",
                    items: ["backend", "frontend", "design"],
                    image: UIImage(named: "ItamCircle")
                ),
                .init(
                    name: "СПОРТ МИСИС",
                    items: ["спорт", "здоровье", "design"],
                    image: UIImage(named: "sportMisisCircle")
                )
            ]
        )
    }()

    private let recommendation: FavoritesSectionModel = {
        .recommendations(
            [
                .init(
                    name: "ITAM",
                    items: ["backend", "frontend", "design"],
                    image: UIImage(named: "ItamCircle")
                ),
                .init(
                    name: "ITAM",
                    items: ["backend", "frontend", "design"],
                    image: UIImage(named: "ItamCircle")
                ),
                .init(
                    name: "ITAM",
                    items: ["backend", "frontend", "design"],
                    image: UIImage(named: "ItamCircle")
                ),
                .init(
                    name: "ITAM",
                    items: ["backend", "frontend", "design"],
                    image: UIImage(named: "ItamCircle")
                )
            ]
        )
    }()

    var organizersPageData: [FavoritesSectionModel] {
        [favorites, recommendation]
    }
}
