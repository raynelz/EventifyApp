//
//  FavoritesOrganizersMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 28.04.2024.
//
import UIKit

struct FavoritesOrganizersMockData {
    static let shared = FavoritesOrganizersMockData()

    private let favorites: FavoritesOrganizersSectionModel = {
        .favorites(
            [
                .init(
                    name: "ITAM",
                    firstTag: "backend",
                    secondTag: "frontend",
                    thirdTag: "design",
                    image: UIImage(named: "ItamCircle")
                ),
                .init(
                    name: "СПОРТ МИСИС",
                    firstTag: "спорт",
                    secondTag: "здоровье",
                    thirdTag: "физ.подготовка",
                    image: UIImage(named: "sportMisisCircle")
                )
            ]
        )
    }()

    private let recommendation: FavoritesOrganizersSectionModel = {
        .recommendations(
            [
                .init(
                    name: "ITAM",
                    firstTag: "backend",
                    secondTag: "frontend",
                    thirdTag: "design",
                    image: UIImage(named: "ItamCircle")
                ),
                .init(
                    name: "ITAM",
                    firstTag: "backend",
                    secondTag: "frontend",
                    thirdTag: "design",
                    image: UIImage(named: "ItamCircle")
                ),
                .init(
                    name: "ITAM",
                    firstTag: "backend",
                    secondTag: "frontend",
                    thirdTag: "design",
                    image: UIImage(named: "ItamCircle")
                ),
                .init(
                    name: "ITAM",
                    firstTag: "backend",
                    secondTag: "frontend",
                    thirdTag: "design",
                    image: UIImage(named: "ItamCircle")
                )
            ]
        )
    }()

    var organizersPageData: [FavoritesOrganizersSectionModel] {
        [favorites, recommendation]
    }
}
