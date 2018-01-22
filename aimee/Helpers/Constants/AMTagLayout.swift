//
//  AMTagLayout.swift
//  aimee
//
//  Created by Chandrachudh on 19/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMTagLayout: UICollectionViewFlowLayout {
    var insertingIndexPaths = [IndexPath]()
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        insertingIndexPaths.removeAll()
        
        for update in updateItems {
            if let indexPath = update.indexPathAfterUpdate,
                update.updateAction == .insert {
                insertingIndexPaths.append(indexPath)
            }
        }
    }

    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        insertingIndexPaths.removeAll()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let visibleLayoutAttributes = super.layoutAttributesForElements(in: rect) {
            if visibleLayoutAttributes.count > 1 {
                for i in 1..<visibleLayoutAttributes.count {
                    let currentLayoutAttributes = visibleLayoutAttributes[i]
                    let previousLayoutAttributes = visibleLayoutAttributes[i-1]
                    
                    let maximumSpacing:CGFloat = 10.0
                    let origin = previousLayoutAttributes.frame.maxX
                    
                    if origin + maximumSpacing + currentLayoutAttributes.frame.size.width < collectionViewContentSize.width {
                        if previousLayoutAttributes.frame.minY == currentLayoutAttributes.frame.minY {
                            var frame = currentLayoutAttributes.frame
                            frame.origin.x = origin + maximumSpacing
                            currentLayoutAttributes.frame = frame
                        }
                    }
                }
                return visibleLayoutAttributes
            }
            else {
                return visibleLayoutAttributes
            }
        }
        return nil
    }
    
//    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath)
//
//        if insertingIndexPaths.contains(itemIndexPath) {
//            attributes?.alpha = 0.0
//            attributes?.transform = CGAffineTransform (
//                scaleX: 0.1,
//                y: 0.1
//            )
//        }
//        return attributes
//    }
}
