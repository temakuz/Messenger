//
//  MessageCollectionViewCell.swift
//  Messenger
//
//  Created by Артем Кузнецов on 06.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var messageLable: UILabel!
//    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
//    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var messageView: MessageView!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var headerView: UIView!

    var headerSubview: UIView?

    
    func addHeaderView(view: UIView) {
        headerSubview?.removeFromSuperview()
        headerSubview = view
        
        headerView.addSubview(view)
        pinHeader(view)
        
    }
    
    func pinHeader(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let views = ["view": view]
        
        let pinHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: [], metrics: nil, views: views)
        let pinVertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: [], metrics: nil, views: views)
        
        headerView.addConstraints(pinHorizontal)
        headerView.addConstraints(pinVertical)
    }
}
