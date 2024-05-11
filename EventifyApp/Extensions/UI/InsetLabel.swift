//
//  InsetLabel.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 04.05.2024.
//

import UIKit

final class InsetLabel: UILabel {
    let insets: UIEdgeInsets
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let insetRect = rect.inset(by: insets)
        
        super.draw(insetRect)
    }
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let width = originalSize.width + insets.horizontal
        let height = originalSize.height + insets.vertical
        
        return CGSize(width: width, height: height)
    }
}
