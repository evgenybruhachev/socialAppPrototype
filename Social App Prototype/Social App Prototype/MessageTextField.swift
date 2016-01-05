//
//  MessageTextField.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 05.01.16.
//  Copyright © 2016 Eugen Briukhachyov. All rights reserved.
//

import UIKit

@IBDesignable
class MessageTextField: UITextView {

    let tailLength:CGFloat = 8
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let bezierPath = UIBezierPath()
        
        bezierPath.moveToPoint(CGPoint(x: rect.minX, y: rect.maxY - tailLength))
        bezierPath.addLineToPoint(CGPoint(x: rect.minX, y: rect.maxY))
        bezierPath.addLineToPoint(CGPoint(x: rect.maxX, y: rect.maxY))
        bezierPath.addLineToPoint(CGPoint(x: rect.maxX, y: rect.maxY - tailLength))
        
        ColorConstants.Gallery.setStroke()
        bezierPath.lineWidth = 1.5
        bezierPath.stroke()
    }

}
