//
//  MessageBackgroundView.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 23.12.15.
//  Copyright © 2015 Eugen Briukhachyov. All rights reserved.
//

import UIKit

@IBDesignable
class MessageContainer: UIView {
    
    let cornerRadius:CGFloat = 5
    let pointerHalfHeight:CGFloat = 5
    let pointerWidth:CGFloat = 5
    
    var isOwnMessage:Bool = true

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let myBezier = UIBezierPath()
        if isOwnMessage {
            myBezier.moveToPoint(CGPoint(x: cornerRadius, y: rect.minY))
            myBezier.addLineToPoint(CGPoint(x: rect.maxX - (cornerRadius + pointerWidth), y: rect.minY))
            myBezier.addArcWithCenter(CGPoint(x: rect.maxX - (cornerRadius + pointerWidth), y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(-M_PI / 2), endAngle: CGFloat(0.0), clockwise: true)
            myBezier.addLineToPoint(CGPoint(x: rect.maxX - pointerWidth, y: rect.midY - pointerHalfHeight))
            myBezier.addLineToPoint(CGPoint(x: rect.maxX, y: rect.midY))
            myBezier.addLineToPoint(CGPoint(x: rect.maxX - pointerWidth, y: rect.midY + pointerHalfHeight))
            myBezier.addLineToPoint(CGPoint(x: rect.maxX - pointerWidth, y: rect.maxY - cornerRadius))
            myBezier.addArcWithCenter(CGPoint(x: rect.maxX - (cornerRadius + pointerWidth), y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI / 2), clockwise: true)
            myBezier.addLineToPoint(CGPoint(x: cornerRadius, y: rect.maxY))
            myBezier.addArcWithCenter(CGPoint(x: cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(M_PI / 2), endAngle: CGFloat(M_PI), clockwise: true)
            myBezier.addLineToPoint(CGPoint(x: rect.minX, y: cornerRadius))
            myBezier.addArcWithCenter(CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(3 * M_PI / 2), clockwise: true)
            myBezier.closePath()
            ColorConstants.Seashell.setFill()
        } else {
            myBezier.moveToPoint(CGPoint(x: cornerRadius + pointerWidth, y: rect.minY))
            myBezier.addLineToPoint(CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
            myBezier.addArcWithCenter(CGPoint(x: rect.maxX - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(-M_PI / 2), endAngle: CGFloat(0.0), clockwise: true)
            myBezier.addLineToPoint(CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
            myBezier.addArcWithCenter(CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI / 2), clockwise: true)
            myBezier.addLineToPoint(CGPoint(x: cornerRadius + pointerWidth, y: rect.maxY))
            myBezier.addArcWithCenter(CGPoint(x: cornerRadius + pointerWidth, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(M_PI / 2), endAngle: CGFloat(M_PI), clockwise: true)
            myBezier.addLineToPoint(CGPoint(x: pointerWidth, y: rect.midY + pointerHalfHeight))
            myBezier.addLineToPoint(CGPoint(x: rect.minX, y: rect.midY))
            myBezier.addLineToPoint(CGPoint(x: pointerWidth, y: rect.midY - pointerHalfHeight))
            myBezier.addLineToPoint(CGPoint(x: pointerWidth, y: cornerRadius))
            myBezier.addArcWithCenter(CGPoint(x: cornerRadius + pointerWidth, y: cornerRadius), radius: cornerRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(3 * M_PI / 2), clockwise: true)
            myBezier.closePath()
            UIColor.whiteColor().setFill()
        }
        
        myBezier.fill()
        ColorConstants.Zircon.setStroke()
        myBezier.stroke()
    }

}
