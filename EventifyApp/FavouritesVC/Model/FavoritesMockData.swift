//
//  FavoritesMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//

import UIKit

struct FavoritesMockData {
    static let shared = FavoritesMockData()

    private let favorites: FavoritesSectionModel = {
        .favorites(
            [
                .init(
                    name: "День открытых дверей университета МИСИС",
                    firstTag: "12 декабря",
                    secondTag: "17:30",
                    thirdTag: "онлайн",
                    image: UIImage(named: "eventIcon2")
                ),
                .init(
                    name: "Ярмарка вакансий",
                    firstTag: "21 марта",
                    secondTag: "10:00",
                    thirdTag: "онлайн",
                    image: UIImage(named: "eventIcon")
                ),
                .init(
                    name: "Весенняя серия турнира «Что? Где? Когда?»",
                    firstTag: "27 марта",
                    secondTag: "18:00",
                    thirdTag: "К-111",
                    image: UIImage(named: "eventIcon3")
                )
            ]
        )
    }()

    private let recommendations: FavoritesSectionModel = {
        .recommendations([
            .init(
                name: "День открытых дверей университета МИСИС",
                firstTag: "12 декабря",
                secondTag: "17:30",
                thirdTag: "онлайн",
                image: UIImage(named: "eventIcon2")
            ),
            .init(
                name: "День открытых дверей университета МИСИС",
                firstTag: "12 декабря",
                secondTag: "17:30",
                thirdTag: "онлайн",
                image: UIImage(named: "eventIcon2")
            ),
            .init(
                name: "День открытых дверей университета МИСИС",
                firstTag: "12 декабря",
                secondTag: "17:30",
                thirdTag: "онлайн",
                image: UIImage(named: "eventIcon2")
            ),
        ])
    }()

    var pageData: [FavoritesSectionModel] {
        [favorites, recommendations]
    }
}
