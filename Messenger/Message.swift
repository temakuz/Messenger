//
//  Message.swift
//  Messenger
//
//  Created by Артем Кузнецов on 06.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation

struct Message {
    let message: String!
    let date: NSDate!
    let sender: User!
    let recipient: User!
    
    init(message: String!, date: NSDate!, sender: User!, recipient: User!) {
        self.message = message
        self.date = date
        self.sender = sender
        self.recipient = recipient
    }
}