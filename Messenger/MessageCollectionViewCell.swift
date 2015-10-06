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
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var messageView: MessageView!
}
