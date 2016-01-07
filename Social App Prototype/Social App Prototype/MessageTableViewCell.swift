//
//  MessageTableViewCell.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 22.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBInspectable let spacer:CGFloat = 99.0
    @IBInspectable let pointerWidth:CGFloat = 5.0
    
    @IBOutlet weak var contentContainer: MessageContainer!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPicContainer: UserPicBackgroundView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var leadingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingMarginDateLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingMarginTextConstraint: NSLayoutConstraint!
    @IBOutlet weak var textImageVerticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var userNameHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var userPicContainerHeightConstraint: NSLayoutConstraint!
    
    var messageInfo:Message?
    var isOwn = true
    
    private var textImageVerticalSpaceConstraintConstant:CGFloat {
        if let text = messageInfo?.text, image = messageInfo?.pictureURL {
            return (text.isEmpty || image.isEmpty) ? 0 : 8
        } else {
            return 0
        }
    }
    
    func setData(messageInfo: Message, isOwnMessage: Bool) {
        self.messageInfo = messageInfo
        self.isOwn = isOwnMessage
        updateUI()
    }
    
    func updateUI() {
        leadingMarginConstraint.constant = isOwn ? -spacer : 0
        userPicContainer.hidden = isOwn
        userPicContainerHeightConstraint.constant = isOwn ? 4 : 32
        userNameLabel.hidden = isOwn
        userNameHeightConstraint.constant = isOwn ? 4 : 21
        trailingMarginConstraint.constant = isOwn ? 0 : spacer
        trailingMarginDateLabelConstraint.constant = isOwn ? (contentContainer.pointerWidth + 2) : (spacer + 2)
        leadingMarginTextConstraint.constant = isOwn ? 25 : 20
        textImageVerticalSpaceConstraint.constant = textImageVerticalSpaceConstraintConstant
        imageViewHeightConstraint.constant = ((messageInfo != nil) && (messageInfo!.pictureURL != nil) && !messageInfo!.pictureURL!.isEmpty) ? 85 : 0
        imageViewHeightConstraint.constant = 0
        contentContainer.isOwnMessage = isOwn
        timeLabel.text = messageInfo?.date.timeShortString ?? ""
        messageText.text = messageInfo?.text ?? ""
        userNameLabel.text = messageInfo?.userNickName ?? ""
        if let avatarURL = messageInfo?.userAvatarURL {
            updateAvatarByURL(avatarURL: avatarURL)
        } else {
            setNilToAvatar()
        }
        userPicContainer.setNeedsDisplay()
        setNeedsDisplay()
    }
    
    func updateAvatarByURL(avatarURL url:String) {
        if let url = NSURL(string: url) {
            let request = NSMutableURLRequest(URL: url)
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request) { data, response, error in
                dispatch_async(dispatch_get_main_queue()) {
                    if let _ = response, data = data {
                        self.avatarImageView.image = UIImage(data: data)
                        self.avatarImageView.setNeedsDisplay()
                    } else {
                        self.setNilToAvatar()
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func setNilToAvatar() {
        avatarImageView.image = nil
        avatarImageView.setNeedsDisplay()
    }
    
}
