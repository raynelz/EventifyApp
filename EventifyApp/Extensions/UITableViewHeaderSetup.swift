//
//  UITableViewHeaderSetup.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 04.05.2024.
//

import UIKit

extension UITableView {
    func setup(header: UIView) {
        header.translatesAutoresizingMaskIntoConstraints = false

        tableHeaderView = header

        NSLayoutConstraint.activate([
            header.widthAnchor.constraint(equalTo: widthAnchor),
            header.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
