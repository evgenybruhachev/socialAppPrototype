//
//  MessageTableViewCell.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 22.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

extension NSDate {
    var timeShortString:String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
        return dateFormatter.stringFromDate(self)
    }
}

class MessageTableViewCell: UITableViewCell {
    
    @IBInspectable let spacer:CGFloat = 75.0
    
    @IBOutlet weak var contentContainer: MessageContainer!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var leadingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingMarginDateLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingMarginTextConstraint: NSLayoutConstraint!
    @IBOutlet weak var textImageVerticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var messageInfo:MessageInfo?
    var isOwn = true
    
    private var textImageVerticalSpaceConstraintConstant:CGFloat {
        if let text = messageInfo?.text, image = messageInfo?.picture {
            return (text.isEmpty || image.isEmpty) ? 0 : 8
        } else {
            return 0
        }
    }
    
    func setData(messageInfo: MessageInfo, isOwnMessage: Bool) {
        self.messageInfo = messageInfo
        self.isOwn = isOwnMessage
        updateUI()
    }
    
    func updateUI() {
        leadingMarginConstraint.constant = isOwn ? -spacer : 0
        trailingMarginConstraint.constant = isOwn ? 0 : spacer
        trailingMarginDateLabelConstraint.constant = isOwn ? contentContainer.pointerWidth : spacer
        leadingMarginTextConstraint.constant = isOwn ? 30 : 20
        textImageVerticalSpaceConstraint.constant = textImageVerticalSpaceConstraintConstant
        imageViewHeightConstraint.constant = ((messageInfo != nil) && (messageInfo!.picture != nil) && !messageInfo!.picture!.isEmpty) ? 85 : 0
        contentContainer.isOwnMessage = isOwn
        timeLabel.text = messageInfo?.date.timeShortString ?? ""
        messageText.text = messageInfo?.text ?? ""
        setNeedsDisplay()
    }
    
}
