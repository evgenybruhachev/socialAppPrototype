//
//  MessageTableViewCell.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 22.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentContainer: MessageContainer!
    
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
        CGContextFillRect(context, rect)*/

    }

    func setData(messageInfo: MessageInfo, isOwnMessage: Bool) {
        //contentContainer.isOwnMessage = isOwnMessage
        switch messageInfo.type {
        case MessageInfo.TYPE_TEXT:
            if let messageText = messageInfo.text {
                //createMessageLabel(messageText)
            }
            break
        case MessageInfo.TYPE_PICTURE:
            break
        default:
            break
        }
    }
    
    func createMessageLabel(messageText:String) {
        let newLabel = UILabel(frame: CGRect(x: 0, y: -50, width: 300, height: 100))
        newLabel.lineBreakMode = .ByWordWrapping
        newLabel.numberOfLines = 0
        newLabel.textColor = ColorConstants.ShadyLady
        newLabel.textAlignment = .Left
        newLabel.text = messageText
        newLabel.sizeThatFits(CGSize(width: newLabel.bounds.size.width, height: CGFloat.max))
        contentContainer.addSubview(newLabel)
        
        //let contentContainerHeight = contentContainer.frame
        //contentContainer.frame = CGRect(x: contentContainerHeight.minX, y: contentContainerHeight.minX, width: contentContainerHeight.width, height: newLabel.frame.height + 10)
    }
}
