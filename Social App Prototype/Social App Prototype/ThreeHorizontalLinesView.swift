//
//  ThreeHorizontalLinesBarButtonItem.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 06.01.16.
//  Copyright © 2016 Eugen Briukhachyov. All rights reserved.
//

import UIKit

class ThreeHorizontalLinesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        var bezierPath = UIBezierPath(rect: rect)
        UIColor.whiteColor().setFill()
        bezierPath.fill()
        
        bezierPath = UIBezierPath()
        
        let innerRect = rect.insetBy(dx: bezierPath.lineWidth, dy: bezierPath.lineWidth)
        
        bezierPath.moveToPoint(CGPoint(x: innerRect.minX, y: innerRect.minY))
        bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX, y: innerRect.minY))
        
        bezierPath.moveToPoint(CGPoint(x: innerRect.minX, y: innerRect.midY))
        bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX, y: innerRect.midY))
        
        bezierPath.moveToPoint(CGPoint(x: innerRect.minX, y: innerRect.maxY))
        bezierPath.addLineToPoint(CGPoint(x: innerRect.maxX, y: innerRect.maxY))
        
        ColorConstants.DarkGray.setStroke()
        bezierPath.stroke()
    }

}
