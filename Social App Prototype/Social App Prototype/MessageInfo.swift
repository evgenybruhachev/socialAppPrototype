//
//  MessageInfo.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 22.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import Foundation

class MessageInfo {
    
    var date:NSDate
    var sender:String
    var text:String?
    var picture:String?
    var isOwnMessage:Bool
    
    init (type: String, date: NSDate, sender: String, isOwnMessage:Bool, text: String?, picture: String?) {
        self.date = date
        self.sender = sender
        self.isOwnMessage = isOwnMessage
        self.text = text
        self.picture = picture
    }
    
}