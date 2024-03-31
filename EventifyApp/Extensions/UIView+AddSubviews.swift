//
//  UIView+Subviews.swift
//  EventifyApp
//
//  Created by Захар Литвинчук on 22.03.2024.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach { addSubview($0) }
  }
}
