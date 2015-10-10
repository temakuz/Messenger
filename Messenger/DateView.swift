//
//  DataView.swift
//  Messenger
//
//  Created by Артем Кузнецов on 10.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class DateView: UIView {
    
    @IBOutlet weak var dateLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViewFromNibNamed("DateView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addViewFromNibNamed("DateView")
    }
}