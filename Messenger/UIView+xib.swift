//
//  UIView+xib.swift
//  Messenger
//
//  Created by Артем Кузнецов on 10.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
//    func addViewFromNibNamed(nibName: String) {
//        let nib = UINib(nibName: nibName, bundle: nil)
//        guard let nibView = nib.instantiateWithOwner(self, options: nil)[0] as? UIView else {
//            return
//        }
//        
//        addSubview(nibView)
//        nibView.frame = bounds
//        pinViewToBounds(nibView)
//    }
//    
//    func pinViewToBounds(view: UIView) {
//        view.translatesAutoresizingMaskIntoConstraints = false
//        let views = ["view": view]
//        
//        let pinHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: [], metrics: nil, views: views)
//        let pinVertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: [], metrics: nil, views: views)
//        
//        addConstraints(pinHorizontal)
//        addConstraints(pinVertical)
//    }
    func addViewFromNibNamed(nibName: String, pinToEdges: Bool = true) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        guard let nibView = nib.instantiateWithOwner(self, options: nil)[0] as? UIView else {
            return nil
        }
        
        addSubview(nibView)
        nibView.frame = bounds
        
        if pinToEdges {
            pinViewToBounds(nibView)
        }
        
        return nibView
    }
    
    func pinViewToBounds(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let views = ["view": view]
        
        let pinHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: [], metrics: nil, views: views)
        let pinVertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: [], metrics: nil, views: views)
        
        addConstraints(pinHorizontal)
        addConstraints(pinVertical)
    }
}