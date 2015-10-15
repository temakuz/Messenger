//
//  User.swift
//  Messenger
//
//  Created by Артем Кузнецов on 06.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation
import UIKit

struct User {
    let id: Int!
    let username: String!
    let image: UIImage?
    
    init(id: Int!, username: String!, image: UIImage?) {
        self.id = id
        self.username = username
        self.image = image
    }
}