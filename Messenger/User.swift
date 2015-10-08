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
    let firstName: String!
    let lastName: String!
    let image: UIImage?
    
    init(firstName: String!, lastName: String!, image: UIImage?) {
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
    }
}