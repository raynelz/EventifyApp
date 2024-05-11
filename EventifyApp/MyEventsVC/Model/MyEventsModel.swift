//
//  ListItem.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 27.04.2024.
//

import UIKit

struct MyEventsModel {
    let name: String
    let items: [String]
    let color: String?
    let image: UIImage?
    
    init(
        name: String,
        items: [String],
        color: String? = nil,
        image: UIImage? = nil
    ) {
        self.name = name
        self.items = items
        self.color = color
        self.image = image
    }
}
