//
//  MessageView.swift
//  Messenger
//
//  Created by Артем Кузнецов on 05.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit
import CoreGraphics

class MessageBabbleView: UIView {

    enum PositionView: Int {
        case Left
        case Right
    }
    var positionView = PositionView!()
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let pointerHeight: CGFloat = 10.0
        let pointerWidth: CGFloat = 10.0
        let borderRadius: CGFloat = 4.0
        let strokeWidth: CGFloat = 1.0
        let borderColor: CGColorRef = UIColor.blackColor().colorWithAlphaComponent(0.15).CGColor
        let backgroundColor: CGColorRef = UIColor.whiteColor().CGColor
        let backgroundColorCurrentCell: CGColorRef = UIColor(red: 241/255, green: 241/255, blue: 242/255, alpha: 1).CGColor
        
        CGContextSetLineJoin(context, .Round);
        CGContextSetLineWidth(context, strokeWidth);
        CGContextSetStrokeColorWithColor(context, borderColor);
        
        if positionView == .Left {
        
            CGContextSetFillColorWithColor(context, backgroundColor);
            CGContextBeginPath(context);

            // Move to the bottom left point
            CGContextMoveToPoint(context, borderRadius + strokeWidth, rect.size.height - borderRadius - strokeWidth);
            
            // Add the triangle lines starting from the bottom left point
            CGContextAddLineToPoint(context, borderRadius + strokeWidth, rect.size.height / 2 + strokeWidth + pointerHeight / 2)
            CGContextAddLineToPoint(context, strokeWidth, rect.size.height / 2 + strokeWidth)
            CGContextAddLineToPoint(context, borderRadius + strokeWidth, rect.size.height / 2 + strokeWidth - pointerHeight / 2)
            
            CGContextAddArcToPoint(context, borderRadius + strokeWidth, strokeWidth, rect.size.width - strokeWidth, strokeWidth, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, rect.size.width - strokeWidth, strokeWidth, rect.size.width - strokeWidth, rect.size.height - strokeWidth, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, rect.size.width - strokeWidth, rect.size.height - strokeWidth, rect.size.width / 2.0 + pointerWidth / 2.0 - strokeWidth, rect.size.height - strokeWidth, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, borderRadius + strokeWidth, rect.size.height - strokeWidth, borderRadius + strokeWidth, strokeWidth, borderRadius - strokeWidth)
        } else {
            CGContextSetFillColorWithColor(context, backgroundColorCurrentCell);
            CGContextBeginPath(context);

            // Move to the right bottom point
            CGContextMoveToPoint(context, rect.size.width - borderRadius - strokeWidth, rect.size.height - borderRadius - strokeWidth);
            
            // Add the triangle lines starting from the bottom right point
            CGContextAddLineToPoint(context, rect.size.width - borderRadius - strokeWidth, rect.size.height / 2 + strokeWidth + pointerHeight / 2)
            CGContextAddLineToPoint(context, rect.size.width - strokeWidth, rect.size.height / 2 + strokeWidth)
            CGContextAddLineToPoint(context, rect.size.width - borderRadius - strokeWidth, rect.size.height / 2 + strokeWidth - pointerHeight / 2)
            
            CGContextAddArcToPoint(context, rect.size.width - borderRadius - strokeWidth, strokeWidth, rect.size.width - strokeWidth - borderRadius - pointerHeight, strokeWidth, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, strokeWidth, strokeWidth, strokeWidth, strokeWidth + borderRadius, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, strokeWidth, rect.size.height - strokeWidth, rect.size.width / 2.0 + pointerWidth / 2.0 - strokeWidth, rect.size.height - strokeWidth, borderRadius - strokeWidth)
            CGContextAddArcToPoint(context, rect.size.width - borderRadius - strokeWidth, rect.size.height - strokeWidth, rect.size.width - borderRadius - strokeWidth, strokeWidth, borderRadius - strokeWidth)
        }
        
        CGContextClosePath(context)
        CGContextDrawPath(context, .FillStroke)
    }
    
}
