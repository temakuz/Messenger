//
//  frameForImage.swift
//  Messenger
//
//  Created by Артем Кузнецов on 08.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation
import UIKit

class FrameForImageView: UIImageView {
    
    var cornerRadius: CGFloat! {
        didSet {
            layer.cornerRadius = cornerRadius
            setNeedsDisplay()
        }
    }
    
    var borderWidth: CGFloat! {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsDisplay()
        }
    }
    
    var borderColor: UIColor! {
        didSet {
            layer.borderColor = borderColor.CGColor
            setNeedsDisplay()
        }
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        install()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        install()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        install()
    }
    
    private func install() {
        cornerRadius = 4
        borderWidth = 1
        borderColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
    }
}