//
//  MessageTableViewCell.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 22.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageTitle: MessageTextLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func drawRect(rect: CGRect) {
        /*
        let context = UIGraphicsGetCurrentContext()
        UIColor.redColor().setFill()
        CGContextFillRect(context, rect)
*/
    }

    func setData(messageInfo: MessageInfo, isOwnMessage: Bool) {
        messageTitle.isOwnMessage = isOwnMessage
        if let messageText = messageInfo.text {
            messageTitle.text = messageText
        }
    }
}
