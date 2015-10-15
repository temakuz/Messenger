//
//  Message.swift
//  Messenger
//
//  Created by Артем Кузнецов on 06.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation

struct Message {
    let id: Int!
    let message: String!
    let date: NSDate!
    let sender: Int!
    let recipient: Int!
    
    init(id: Int!, message: String!, date: NSDate!, sender: Int!, recipient: Int!) {
        self.id = id
        self.message = message
        self.date = date
        self.sender = sender
        self.recipient = recipient
    }
}