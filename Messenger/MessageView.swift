//
//  MessageView.swift
//  Messenger
//
//  Created by Артем Кузнецов on 05.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit
import CoreGraphics


@IBDesignable

class MessageView: UIView {

    enum PositionView: Int {
        case Left
        case Right
    }
    var positionView = PositionView!()
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let pointerHeight: CGFloat = 15.0
        let pointerWidth: CGFloat = 15.0
        let borderRadius: CGFloat = 10.0
        let strokeWidth: CGFloat = 1.5
        let borderColor: CGColorRef = UIColor.greenColor().CGColor
        let backgroundColor: CGColorRef = UIColor.whiteColor().CGColor
        
        CGContextSetLineJoin(context, .Round);
        CGContextSetLineWidth(context, strokeWidth);
        CGContextSetStrokeColorWithColor(context, borderColor);
        CGContextSetFillColorWithColor(context, backgroundColor);
        
        // Draw and fill the bubble left
        CGContextBeginPath(context);
        
        if positionView == .Left {
            // Move to the bottom left point
            CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5, rect.size.height - borderRadius - strokeWidth - 0.5);
            
            // Add the triangle lines starting from the bottom left point
            CGContextAddLineToPoint(context, borderRadius + strokeWidth + 0.5, rect.size.height / 2 + strokeWidth + pointerHeight / 2 - 0.5)
            CGContextAddLineToPoint(context, strokeWidth + 0.5, rect.size.height / 2 + strokeWidth)
            CGContextAddLineToPoint(context, borderRadius + strokeWidth + 0.5, rect.size.height / 2 + strokeWidth - pointerHeight / 2 + 0.5)
            
            CGContextAddArcToPoint(context, borderRadius + strokeWidth + 0.5, strokeWidth + 0.5, rect.size.width - strokeWidth - 0.5, strokeWidth + 0.5, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, rect.size.width - strokeWidth - 0.5, strokeWidth + 0.5, rect.size.width - strokeWidth - 0.5, rect.size.height - strokeWidth - 0.5, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, rect.size.width - strokeWidth - 0.5, rect.size.height - strokeWidth - 0.5, rect.size.width / 2.0 + pointerWidth / 2.0 - strokeWidth + 0.5, rect.size.height - strokeWidth - 0.5, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, borderRadius + strokeWidth + 0.5, rect.size.height - strokeWidth - 0.5, strokeWidth + 0.5 + borderRadius, strokeWidth + 0.5, borderRadius - strokeWidth)
        } else {
            // Draw and fill the bubble right
            CGContextBeginPath(context);
            
            // Move to the right bottom point
            CGContextMoveToPoint(context, rect.size.width - borderRadius - strokeWidth - 0.5, rect.size.height - borderRadius - strokeWidth - 0.5);
            
            // Add the triangle lines starting from the bottom right point
            CGContextAddLineToPoint(context, rect.size.width - borderRadius - strokeWidth - 0.5, rect.size.height / 2 + strokeWidth + pointerHeight / 2 - 0.5)
            CGContextAddLineToPoint(context, rect.size.width - strokeWidth - 0.5, rect.size.height / 2 + strokeWidth)
            CGContextAddLineToPoint(context, rect.size.width - borderRadius - strokeWidth - 0.5, rect.size.height / 2 + strokeWidth - pointerHeight / 2 + 0.5)
            
            CGContextAddArcToPoint(context, rect.size.width - borderRadius - strokeWidth - 0.5, strokeWidth + 0.5, rect.size.width - strokeWidth - borderRadius - pointerHeight - 0.5, strokeWidth + 0.5, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, strokeWidth + 0.5, strokeWidth - 0.5, strokeWidth + 0.5, strokeWidth + borderRadius + 0.5, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, strokeWidth + 0.5, rect.size.height - strokeWidth - 0.5, rect.size.width / 2.0 + pointerWidth / 2.0 - strokeWidth + 0.5, rect.size.height - strokeWidth - 0.5, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, rect.size.width - borderRadius - strokeWidth - 0.5, rect.size.height - strokeWidth - 0.5, rect.size.width - pointerWidth - strokeWidth + 0.5, strokeWidth + 0.5, borderRadius - strokeWidth)
        }
        
        CGContextClosePath(context)
        CGContextDrawPath(context, .Stroke)
    }
    
}
