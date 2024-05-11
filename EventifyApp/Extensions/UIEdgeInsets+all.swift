//
//  UIEdgeInsets.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 04.05.2024.
//

import UIKit

extension UIEdgeInsets {
    init(all value: CGFloat) {
        self.init(
            top: value,
            left: value,
            bottom: value,
            right: value
        )
    }
    
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }
    
    var horizontal: CGFloat {
        return left + right
    }
    
    var vertical: CGFloat {
        return top + bottom
    }
}
