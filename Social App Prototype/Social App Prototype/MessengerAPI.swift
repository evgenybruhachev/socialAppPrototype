//
//  MessengerAPI.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 08.01.16.
//  Copyright © 2016 Eugen Briukhachyov. All rights reserved.
//

import Foundation

class MessengerAPI {
    
    private let hostURL = "http://52.10.75.149/"
    
    var createNewSessionURL:String {
        return hostURL + "signup"
    }
    
    var updateSessionURL:String {
        return hostURL + "session"
    }
    
    var getMessagesURL:String {
        return hostURL + "messages"
    }
    
    func getNewSessionID(handlerFunction handler: ((String) -> Void)) {
        let url = NSURL(string: createNewSessionURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                if let _ = response, data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        if let sessionId = json["session"] as? String {
                            handler(sessionId)
                        }
                    } catch {
                        print("error serializing JSON: \(error)")
                    }
                } else {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func updateSessionByID(sessionId sessionId: String, handlerFunction handler: ((Int) -> Void)) {
        let url = NSURL(string: updateSessionURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = "{\"session\": \"\(sessionId)\"}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                if let _ = response, data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        if let userInfo = json["User"] as? NSDictionary {
                            if let userId:Int = userInfo["id"] as? Int {
                                handler(userId)
                            }
                        }
                    } catch {
                        print("error serializing JSON: \(error)")
                    }
                } else {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func getMessagesPack(sessionId:String, pagingSize:Int?, newestMessageId:Int?, oldestMessageId:Int?, handlerFunction handler: ((NSArray) -> Void)) {
        var stringURL = getMessagesURL + "?session=\(sessionId)"
        
        func updateParametersMarks() {
            stringURL += "&"
        }
        
        updateParametersMarks()
        
        if let pageSize = pagingSize {
            updateParametersMarks()
            stringURL += "paging_size=\(pageSize)"
        }
        if let newestMessageIdWrapped = newestMessageId {
            updateParametersMarks()
            stringURL += "newest_message_id=\(newestMessageIdWrapped)"
        }
        if let oldestMessageIdWrapped = oldestMessageId {
            updateParametersMarks()
            stringURL += "oldest_message_id=\(oldestMessageIdWrapped)"
        }
        
        let url = NSURL(string: stringURL)!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                if let _ = response, data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        if let messages:NSArray = json["messages"] as? NSArray {
                            handler(messages)
                        }
                    } catch {
                        print("error serializing JSON: \(error)")
                    }
                } else {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
}


