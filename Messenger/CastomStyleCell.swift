//
//  CastomStyleCell.swift
//  Messenger
//
//  Created by Артем Кузнецов on 06.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit

class CastomStyleCell: UICollectionViewLayout {


    enum PositionCell: Int {
        case Left
        case Right
    }
    
    var positionCell = PositionCell.Right
    // 1
    var delegate: MessageLayoutDelegate!
    
    // 2
    var numberOfColumns = 1
    var cellPadding: CGFloat = 6.0
    
    // 3
    private var cache = [UICollectionViewLayoutAttributes]()
    
    // 4
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override func prepareLayout() {
        // 1
        if cache.isEmpty {
            // 2
            let columnWidth = contentWidth * 0.7
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var column = 0
            var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
            
            // 3
            
            for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                let messageHeight = delegate.collectionView(collectionView!, heightForMessageViewAtIndexPath: indexPath,
                    withWidth: columnWidth)
                var minHeight = messageHeight > 85 ? messageHeight : 85
                let height = cellPadding + minHeight + cellPadding + 55
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)

                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                
                let position = delegate.collectioView(collectionView!, positionCellViewAtIndexPath: indexPath)
                
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                
                if position == 0 {
                    attributes.frame = CGRectMake(contentWidth - columnWidth , yOffset[column], columnWidth, height)
                    positionCell = .Right
                } else {
                    attributes.frame = CGRectMake(cellPadding, yOffset[column], columnWidth, height)
                    positionCell = .Left
                }
                cache.append(attributes)

                yOffset[column] += height
            }
        }
    }

    
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes  in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
}

protocol MessageLayoutDelegate: class {
    // 1
    func collectionView(collectionView: UICollectionView, heightForMessageViewAtIndexPath indexPath:NSIndexPath, withWidth:CGFloat) -> CGFloat
    func collectioView(collectionView: UICollectionView, positionCellViewAtIndexPath indexPath: NSIndexPath) -> Int
}