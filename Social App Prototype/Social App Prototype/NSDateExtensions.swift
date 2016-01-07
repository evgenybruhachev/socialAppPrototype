//
//  NSDateExtensions.swift
//  Social App Prototype
//
//  Created by Eugen Briukhachyov on 08.01.16.
//  Copyright © 2016 Eugen Briukhachyov. All rights reserved.
//

import Foundation

extension NSDate {
    var timeShortString:String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
        return dateFormatter.stringFromDate(self)
    }
}
