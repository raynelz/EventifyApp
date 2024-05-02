//
//  Reusable.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 02.05.2024.
//

import UIKit

protocol Reusable {
    static var id: String { get }
}

extension Reusable {
    static var id: String {
        return String(describing: Self.self)
    }
}

protocol Configurable {
    associatedtype DataType
    func configure(with data: DataType)
}

extension UITableViewCell: Reusable {}
