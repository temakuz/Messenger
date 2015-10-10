//
//  MessageTextField.swift
//  Messenger
//
//  Created by Артем Кузнецов on 10.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class MessageTextField: UITextField {
    
    @IBInspectable var leftInset: CGFloat = 10
    @IBInspectable var rightInset: CGFloat = 0
    @IBInspectable var strokeWidth: CGFloat = 1
    @IBInspectable var strokeColor: UIColor = UIColor.blackColor().colorWithAlphaComponent(0.1)
    
    private let borderHeightMultiplier: CGFloat = 0.2
    
    private var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, edgeInsets)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, edgeInsets)
    }
    
    override func drawRect(rect: CGRect) {
        let height = rect.size.height
        let width = rect.size.width
        let borderStartPosition = height - height * borderHeightMultiplier
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineJoin(context, .Round)
        CGContextSetLineWidth(context, strokeWidth)
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor)
        
        CGContextBeginPath(context)
        
        CGContextMoveToPoint(context, 0, borderStartPosition)
        CGContextAddLineToPoint(context, 0, height)
        CGContextAddLineToPoint(context, width, height)
        CGContextAddLineToPoint(context, width, borderStartPosition)
        
        CGContextDrawPath(context, .Stroke)
    }
    
}