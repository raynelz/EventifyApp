//
//  FavoritesMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//

import UIKit

struct FavoritesEventsMockData {
    static let shared = FavoritesEventsMockData()

    private let favorites: FavoritesSectionModel = {
        .favorites(
            [
                .init(
                    name: "День открытых дверей университета МИСИС",
                    items: ["12 декабря", "17:30", "онлайн", "12 декабря", "17:30", "онлайн"],
                    image: UIImage(named: "eventIcon2")
                ),
                .init(
                    name: "Ярмарка вакансий",
                    items: ["12 декабря", "17:30", "онлайн", "12 декабря", "17:30", "онлайн"],
                    image: UIImage(named: "eventIcon")
                ),
                .init(
                    name: "Весенняя серия турнира «Что? Где? Когда?»",
                    items: ["12 декабря", "17:30", "онлайн", "12 декабря", "17:30", "онлайн"],
                    image: UIImage(named: "eventIcon3")
                )
            ]
        )
    }()

    private let recommendations: FavoritesSectionModel = {
        .recommendations([
            .init(
                name: "День открытых дверей университета МИСИС",
                items: ["12 декабря", "17:30", "онлайн", "12 декабря", "17:30", "онлайн"],
                image: UIImage(named: "eventIcon2")
            ),
            .init(
                name: "День открытых дверей университета МИСИС",
                items: ["12 декабря", "17:30", "онлайн", "12 декабря", "17:30", "онлайн"],
                image: UIImage(named: "eventIcon2")
            ),
            .init(
                name: "День открытых дверей университета МИСИС",
                items: ["12 декабря", "17:30", "онлайн", "12 декабря", "17:30", "онлайн"],
                image: UIImage(named: "eventIcon2")
            ),
        ])
    }()

    var favoritesPageData: [FavoritesSectionModel] {
        [favorites, recommendations]
    }
}
