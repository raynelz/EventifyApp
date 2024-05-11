//
//  LeftAttribute.swift
//  EventifyApp
//
//  Created by Рассказов Глеб on 11.05.2024.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y > maxY {
                leftMargin = sectionInset.left
            }
            
            if layoutAttribute.frame.origin.x == sectionInset.left || leftMargin + layoutAttribute.frame.width > collectionViewContentSize.width {
                layoutAttribute.frame.origin.x = sectionInset.left
                leftMargin = sectionInset.left
            } else {
                layoutAttribute.frame.origin.x = leftMargin
            }
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}
