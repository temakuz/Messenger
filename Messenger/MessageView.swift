//
//  MessageView.swift
//  Messenger
//
//  Created by Артем Кузнецов on 12.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation
import UIKit

class MessageView: UIView {
    
    @IBOutlet weak var messageLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewFromNibNamed("MessageView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addViewFromNibNamed("MessageView")
    }
}