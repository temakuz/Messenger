//
//  HeaderView.swift
//  Messenger
//
//  Created by Артем Кузнецов on 10.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class HeaderView: UIView {
    
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var userImage: FrameForImageView!
    @IBOutlet weak var dateLable: UILabel!
    
    @IBOutlet weak var dateOutgoingMessageLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewFromNibNamed("HeaderView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addViewFromNibNamed("HeaderView")
    }
    
}

