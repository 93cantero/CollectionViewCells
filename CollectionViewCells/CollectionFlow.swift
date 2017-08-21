//
//  CollectionFlow.swift
//  CollectionViewCells
//
//  Created by Cantero Francisco on 11/08/2017.
//

import UIKit

class CollectionFlow: UICollectionViewFlowLayout {
    
    let cellSpacing: CGFloat = 10
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let attributes = super.layoutAttributesForElements(in: rect) {
            for (index, attribute) in attributes.enumerated() {
                if index == 0 { continue }
                let prevLayoutAttributes = attributes[index - 1]
                let origin = prevLayoutAttributes.frame.maxX
                if(origin + cellSpacing
                    + attribute.frame.size.width < self.collectionViewContentSize.width) {
                    attribute.frame.origin.x = origin + cellSpacing
                }
            }
            return attributes
        }
        return nil
    }
    
}
