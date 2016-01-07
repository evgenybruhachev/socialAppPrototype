//
//  UserPicImageView.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 07.01.16.
//  Copyright © 2016 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class UserPicImageView: UIImageView {

    override func drawRect(rect: CGRect) {
        //let innerRect = CGRectInset(rect, 1, 1)
        super.drawRect(rect)
        
        let bezierPath = UIBezierPath(rect: rect)
        UIColor.redColor().setFill()
        bezierPath.fill()
    }

}
