//
//  CastomStyleCell.swift
//  Messenger
//
//  Created by Артем Кузнецов on 06.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit

@IBDesignable

class CastomStyleCell: UICollectionViewLayout {

    private enum PositionCell: Int {
        case Left
        case Right
    }
    
    private var positionCell = PositionCell.Right

    var delegate: MessageLayoutDelegate!
    
    private var numberOfColumns = 1

    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var cellPadding: CGFloat = 0
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - (insets.left + insets.right)
    }
    
    override func prepareLayout() {
        
        guard let collectionView = collectionView else {
            return
        }
        
        let contentWidthCell = contentWidth * 0.7
        
        if cache.isEmpty {
            for section in 0..<collectionView.numberOfSections() {
                for item in 0..<collectionView.numberOfItemsInSection(section) {
                    let indexPath = NSIndexPath(forItem: item, inSection: section)
                    let messageHeight = delegate.collectionView(collectionView, heightForMessageViewAtIndexPath: indexPath, withWidth: contentWidthCell)
                    let positionCell = delegate.collectioView(collectionView, positionCellViewAtIndexPath: indexPath)
                    let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                    
                    let frame: CGRect
                    if positionCell == 0 {
                        frame = CGRectMake(contentWidth - contentWidthCell , contentHeight, contentWidthCell, messageHeight + 55)
                    } else {
                        frame = CGRectMake(cellPadding, contentHeight, contentWidthCell, messageHeight + 85)
                    }
                    contentHeight += CGRectGetHeight(frame)
                    
                    attributes.frame = frame
                    cache.append(attributes)
                }
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
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        return cache[indexPath.row]
    }
    
}

protocol MessageLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForMessageViewAtIndexPath indexPath:NSIndexPath, withWidth:CGFloat) -> CGFloat
    
    func collectioView(collectionView: UICollectionView, positionCellViewAtIndexPath indexPath: NSIndexPath) -> Int
}