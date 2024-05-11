//
//  MockData.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.04.2024.
//

import UIKit

struct MyEventsMockData {
    static let shared = MyEventsMockData()

    private let upcoming: MyEventsSectionModel = {
        .upcoming(
            [
                .init(
                    name: "День дверей университета МИСИС",
                    items: ["12 декабря", "17:30", "Онлайн"],
                    color: "#F18EF0",
                    image: UIImage(named: "qr")
                ),
                .init(
                    name: "ITAM-Hack",
                    items: ["26 апреля", "18:00", "Б-1"],
                    color: "#DEF14A",
                    image: UIImage(named: "qr")
                ),
                .init(
                    name: "Открытый ректорат",
                    items: ["21 декабря", "16:30", "Б-2"],
                    color: "F18EF0",
                    image: UIImage(named: "qr")
                ),
                .init(
                    name: "День открытых дверей университета МИСИС",
                    items: ["12 декабря", "17:30", "Онлайн"],
                    color: "#DEF14A",
                    image: UIImage(named: "qr")
                ),
                .init(
                    name: "День открытых дверей университета МИСИС",
                    items: ["12 декабря", "17:30", "Онлайн"],
                    color: "#F18EF0",
                    image: UIImage(named: "qr")
                )
            ]
        )
    }()

    private let recommendations: MyEventsSectionModel = {
        .recommendations([
            .init(
                name: "День открытых дверей университета МИСИС",
                items: ["12 декабря", "17:30", "Онлайн"],
                color: "#000000",
                image: UIImage(named: "eventIcon2")
            ),
            .init(
                name: "День открытых дверей университета МИСИС",
                items: ["12 декабря", "17:30", "Онлайн"],
                color: "#000000",
                image: UIImage(named: "eventIcon2")
            ),
            .init(
                name: "День открытых дверей университета МИСИС",
                items: ["12 декабря", "17:30", "Онлайн"],
                color: "#000000",
                image: UIImage(named: "eventIcon2")
            ),
        ])
    }()

    var pageData: [MyEventsSectionModel] {
        [upcoming, recommendations]
    }
}
