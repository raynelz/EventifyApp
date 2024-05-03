//
//  SearchMockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 03.05.2024.
//

import UIKit

struct SearchMockData {
    static let shared = SearchMockData()

    let studentsData = [
        CategoriesModel(
            title: "Спорт",
            image: UIImage(named: "sport"),
            color: "#EA4545"
        ),
        CategoriesModel(
            title: "Наука",
            image: UIImage(named: "science"),
            color: "#073B8F"
        ),
        CategoriesModel(
            title: "ITAM",
            image: UIImage(named: "itam"),
            color: "#000000"
        )
    ]

    let abiturientsData = [
        CategoriesModel(
            title: "Экскурсии",
            image: UIImage(named: "excursions"),
            color: "#FF9900"
        ),
        CategoriesModel(
            title: "Курсы",
            image: UIImage(named: "cources"),
            color: "#00ABB6"
        ),
        CategoriesModel(
            title: "Олимпиады",
            image: UIImage(named: "olimpiads"),
            color: "#9747FF"
        )
    ]
}
