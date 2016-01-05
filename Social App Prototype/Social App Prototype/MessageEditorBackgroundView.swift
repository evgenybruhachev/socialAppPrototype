//
//  MessageEditorBackgroundView.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 05.01.16.
//  Copyright © 2016 Eugen Briukhachyov. All rights reserved.
//

import UIKit

@IBDesignable
class MessageEditorBackgroundView: UIView {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let bezierPath = UIBezierPath()
        
        bezierPath.moveToPoint(CGPoint(x: rect.minX, y: rect.minY))
        bezierPath.addLineToPoint(CGPoint(x: rect.maxX, y: rect.minY))
        
        ColorConstants.Gallery.setStroke()
        bezierPath.lineWidth = 1.5
        bezierPath.stroke()
    }

}
