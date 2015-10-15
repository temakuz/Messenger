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
    
    static func messagesUpdate(firstUser: User, secondUser: User, offset: Int, success: ([Message]) -> (), failure: Session.Failure) {
        let parameters = ["sender_id": String(firstUser.id), "receiver_id": String(secondUser.id), "last_message_id": String(offset)]
        
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
}