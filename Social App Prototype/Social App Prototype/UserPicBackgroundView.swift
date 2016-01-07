//
//  UserPicBackgroundView.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 07.01.16.
//  Copyright © 2016 Eugen Briukhachyov. All rights reserved.
//

import UIKit

@IBDesignable
class UserPicBackgroundView: UIView {

    override func drawRect(rect: CGRect) {
        let innerRect = CGRectInset(rect, 1, 1)
        
        let bezierPath = UIBezierPath(roundedRect: innerRect, cornerRadius: 2)
        ColorConstants.Zircon.setStroke()
        bezierPath.stroke()
    }

}
