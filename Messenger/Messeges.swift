//
//  Messeges.swift
//  Messenger
//
//  Created by Артем Кузнецов on 15.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation

class Messages {
    private static let baseURL = NSURL(string: "http://54.65.210.65/cakephp-2.7.5/messages")!
    
    static func messagesUpdate(fromUser: User, toUser: User, offset: Int, success: ([Message]?) -> (), failure: Session.Failure) {
        let parameters = ["sender_id": String(fromUser.id), "receiver_id": String(toUser.id), "last_message_id": String(offset)]
        
        Session.instance.GET(baseURL, parameters: parameters,
            success: { data in
                guard let data = data else {
                    return
                }
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! [String: AnyObject]
                    let messages = Parser.parse(json)
                    
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        success(messages)
                    }
                }
                
                catch {
                    failure(error)
                }
            },
            failure: { error in
                failure(error)
        })
    }
    
    static func sendMessage(message: Message, success: (() -> ())?, failure: Session.Failure?) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let parameters = ["sender_id": String(message.sender), "receiver_id": String(message.recipient), "text": String(message.message), "created_at": dateFormatter.stringFromDate(NSDate())]
        
        let path = baseURL.URLByAppendingPathComponent("create")
        Session.instance.POST(path, parameters: parameters,
            success: { data in
                dispatch_async(dispatch_get_main_queue()) {
                    success?()
                }
                
            }) { error in
                dispatch_async(dispatch_get_main_queue()) {
                    failure?(error)
                }
        }
    }
}