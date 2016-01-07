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
    
    let cornerRadius:CGFloat = 3
    let pointerHalfHeight:CGFloat = 5
    let pointerWidth:CGFloat = 5
    
    var isOwnMessage:Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let bezierPath = UIBezierPath()
        
        let innerRect = rect.insetBy(dx: bezierPath.lineWidth, dy: bezierPath.lineWidth)
        
        if isOwnMessage {
            bezierPath.moveToPoint(CGPoint(x: innerRect.minX + cornerRadius, y: innerRect.minY))
            bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX - (cornerRadius + pointerWidth), y: innerRect.minY))
            bezierPath.addArcWithCenter(CGPoint(x: innerRect.maxX - (cornerRadius + pointerWidth), y: innerRect.minY + cornerRadius), radius: cornerRadius, startAngle: CGFloat(-M_PI / 2), endAngle: CGFloat(0.0), clockwise: true)
            bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX - pointerWidth, y: innerRect.midY - pointerHalfHeight))
            bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX, y: innerRect.midY))
            bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX - pointerWidth, y: innerRect.midY + pointerHalfHeight))
            bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX - pointerWidth, y: innerRect.maxY - cornerRadius))
            bezierPath.addArcWithCenter(CGPoint(x: innerRect.maxX - (cornerRadius + pointerWidth), y: innerRect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI / 2), clockwise: true)
            bezierPath.addLineToPoint(CGPoint(x: innerRect.minX + cornerRadius, y: innerRect.maxY))
            bezierPath.addArcWithCenter(CGPoint(x: innerRect.minX + cornerRadius, y: innerRect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(M_PI / 2), endAngle: CGFloat(M_PI), clockwise: true)
            bezierPath.addLineToPoint(CGPoint(x: innerRect.minX, y: innerRect.minY + cornerRadius))
            bezierPath.addArcWithCenter(CGPoint(x: innerRect.minX + cornerRadius, y: innerRect.minY + cornerRadius), radius: cornerRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(3 * M_PI / 2), clockwise: true)
            bezierPath.closePath()
            ColorConstants.Seashell.setFill()
        } else {
            bezierPath.moveToPoint(CGPoint(x: innerRect.minX + cornerRadius + pointerWidth, y: innerRect.minY))
            bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX - cornerRadius, y: innerRect.minY))
            bezierPath.addArcWithCenter(CGPoint(x: innerRect.maxX - cornerRadius, y: innerRect.minY + cornerRadius), radius: cornerRadius, startAngle: CGFloat(-M_PI / 2), endAngle: CGFloat(0.0), clockwise: true)
            bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX, y: innerRect.maxY - cornerRadius))
            bezierPath.addArcWithCenter(CGPoint(x: innerRect.maxX - cornerRadius, y: innerRect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI / 2), clockwise: true)
            bezierPath.addLineToPoint(CGPoint(x: innerRect.minX + cornerRadius + pointerWidth, y: innerRect.maxY))
            bezierPath.addArcWithCenter(CGPoint(x: innerRect.minX + cornerRadius + pointerWidth, y: innerRect.maxY - cornerRadius), radius: cornerRadius, startAngle: CGFloat(M_PI / 2), endAngle: CGFloat(M_PI), clockwise: true)
            bezierPath.addLineToPoint(CGPoint(x: innerRect.minX + pointerWidth, y: innerRect.midY + pointerHalfHeight))
            bezierPath.addLineToPoint(CGPoint(x: innerRect.minX, y: innerRect.midY))
            bezierPath.addLineToPoint(CGPoint(x: innerRect.minX + pointerWidth, y: innerRect.midY - pointerHalfHeight))
            bezierPath.addLineToPoint(CGPoint(x: innerRect.minX + pointerWidth, y: innerRect.minY + cornerRadius))
            bezierPath.addArcWithCenter(CGPoint(x: innerRect.minX + cornerRadius + pointerWidth, y: innerRect.minY + cornerRadius), radius: cornerRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(3 * M_PI / 2), clockwise: true)
            bezierPath.closePath()
            UIColor.whiteColor().setFill()
        }
        
        bezierPath.fill()
        ColorConstants.Zircon.setStroke()
        bezierPath.stroke()
    }

}
