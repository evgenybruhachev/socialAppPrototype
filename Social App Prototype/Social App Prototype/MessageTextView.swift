//
//  MessageTextField.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 05.01.16.
//  Copyright © 2016 Eugen Briukhachyov. All rights reserved.
//

import UIKit

@IBDesignable
class MessageTextView: UITextView {

    let tailLength:CGFloat = 8
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let bezierPath = UIBezierPath()
        
        let innerRect = rect.insetBy(dx: bezierPath.lineWidth, dy: bezierPath.lineWidth)
        
        bezierPath.moveToPoint(CGPoint(x: innerRect.minX, y: innerRect.maxY - tailLength))
        bezierPath.addLineToPoint(CGPoint(x: innerRect.minX, y: innerRect.maxY))
        bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX, y: innerRect.maxY))
        bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX, y: innerRect.maxY - tailLength))
        
        ColorConstants.Gallery.setStroke()
        bezierPath.stroke()
    }

}
