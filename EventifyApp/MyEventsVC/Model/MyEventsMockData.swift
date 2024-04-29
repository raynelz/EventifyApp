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
                    name: "День открытых дверей университета МИСИС",
                    date: "12 декабря",
                    time: "17:30",
                    location: "Онлайн",
                    color: "#F18EF0",
                    image: UIImage(named: "qr")
                ),
                .init(
                    name: "ITAM-Hack",
                    date: "26 апреля",
                    time: "18:00",
                    location: "Б-1",
                    color: "#DEF14A",
                    image: UIImage(named: "qr")
                ),
                .init(
                    name: "Открытый ректорат",
                    date: "21 декабря",
                    time: "16:30",
                    location: "Б-2",
                    color: "F18EF0",
                    image: UIImage(named: "qr")
                ),
                .init(
                    name: "День открытых дверей университета МИСИС",
                    date: "12 декабря",
                    time: "17:30",
                    location: "Онлайн",
                    color: "#DEF14A",
                    image: UIImage(named: "qr")
                ),
                .init(
                    name: "День открытых дверей университета МИСИС",
                    date: "12 декабря",
                    time: "17:30",
                    location: "Онлайн",
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
                date: "12 декабря",
                time: "17:30",
                location: "онлайн",
                color: "#000000",
                image: UIImage(named: "eventIcon2")
            ),
            .init(
                name: "День открытых дверей университета МИСИС",
                date: "12 декабря",
                time: "17:30",
                location: "онлайн",
                color: "#000000",
                image: UIImage(named: "eventIcon2")
            ),
            .init(
                name: "День открытых дверей университета МИСИС",
                date: "12 декабря",
                time: "17:30",
                location: "онлайн",
                color: "#000000",
                image: UIImage(named: "eventIcon2")
            ),
        ])
    }()

    var pageData: [MyEventsSectionModel] {
        [upcoming, recommendations]
    }
}
