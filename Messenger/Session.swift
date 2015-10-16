//
//  Session.swift
//  Messenger
//
//  Created by Артем Кузнецов on 15.10.15.
//  Copyright © 2015 Артём Кузнецов. All rights reserved.
//

import Foundation

class Session: NSObject {
    
    static let instance = Session()
        
    private var session = NSURLSession(configuration: .defaultSessionConfiguration())
    
    //MARK: Initialization
    private override init() {
        super.init()
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    //MARK: Requests
    func GET(path: NSURL, parameters: [String: String]?, success: Success?, failure: Failure?) -> NSURLSessionDataTask {
        let request = requestWithPath(path, method: "GET", parameters: parameters)
        let task = session.dataTaskWithRequest(request) { data, responce, error in
            guard error == nil else {
                print(error)
                failure?(error!)
                return
            }
            success?(data)
        }
        task.resume()
        
        return task
    }
    
    private func requestWithPath(var path: NSURL, method: String, parameters: [String: String]?) -> NSURLRequest {
        
        if method == "GET" {
            if let currentParameters = parameters {
                var parametersString = "?"
                
                for (param, value) in currentParameters {
                    parametersString += param + "=" + value + "&"
                }
                parametersString.removeAtIndex(parametersString.endIndex.predecessor())
                
                if let newURL = NSURL(string: path.absoluteString + parametersString) {
                    path = newURL
                }
                
            }
        }
        
        let request = NSMutableURLRequest(URL: path)
        request.HTTPMethod = method
        
        return request
    }
}

extension Session {
    typealias Success = (NSData?) -> Void
    typealias Failure = (ErrorType) -> Void
}