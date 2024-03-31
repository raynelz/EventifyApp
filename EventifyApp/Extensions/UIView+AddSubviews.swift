//
//  UIView+AddSubviews.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 31.03.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}
