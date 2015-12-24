//
//  MessageTextLabel.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 22.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class MessageTextLabel: UILabel {
    
    let paddings = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    var isOwnMessage:Bool = true
    
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, paddings))
    }
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
    }

}
