//
//  Parser.swift
//  Messenger
//
//  Created by Артем Кузнецов on 15.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation

class Parser {
    
    static func parse(data: [String: AnyObject]) -> [Message] {
        var messagesArray = [Message]()
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let messages = data["messages"]! as! [AnyObject]
        
        for currentMessage in messages {
            let messageDictionary = currentMessage["Message"]! as! [String: AnyObject]

            let id = Int(messageDictionary["id"]! as! String)
            let text = messageDictionary["text"]! as! String
            let date = dateFormater.dateFromString(messageDictionary["created_at"]! as! String)
            
            let senderID = Int(messageDictionary["sender_id"]! as! String)
            let receiverID = Int(messageDictionary["receiver_id"]! as! String)
            
            let currentMessage = Message(id: id, message: text, date: date, sender: senderID, recipient: receiverID)
            
            messagesArray.append(currentMessage)
        }
        
        return messagesArray
    }
}