//
//  MessageInfo.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 22.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import Foundation

class Message {
    
    var id:Int?
    var userId:Int?
    var userNickName:String?
    var userAvatarURL:String?
    var date:NSDate
    var text:String?
    var pictureURL:String?
    
    init (serializedJsonObject json:NSDictionary) {
        if let userInfo = json["User"] as? NSDictionary {
            if let userId = userInfo["id"] as? Int {
                self.userId = userId
            }
            if let username = userInfo["nickname"] as? String {
                self.userNickName = username
            }
            if let avatarURL = userInfo["avatar_url"] as? String {
                self.userAvatarURL = avatarURL
            }
        }
        if let messageInfo = json["Message"] as? NSDictionary {
            if let messageId = messageInfo["id"] as? Int {
                self.id = messageId
            }
            if let pictureURL = messageInfo["image_url"] as? String {
                self.pictureURL = pictureURL
            }
            if let updatedDate = messageInfo["updated_at"] as? String {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                self.date = dateFormatter.dateFromString(updatedDate)!
            } else {
                self.date = NSDate()
            }
            if let messageText = messageInfo["text"] as? String {
                self.text = messageText
            }
        } else {
            self.date = NSDate()
        }
    }
    
}