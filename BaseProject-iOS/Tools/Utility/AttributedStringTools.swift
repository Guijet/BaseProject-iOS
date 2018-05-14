//
//  AttributedStringTools.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-01-27.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit

//Concatenate attributed strings
extension NSAttributedString{
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let middleSpacing = NSMutableAttributedString(string: " ", attributes: nil)
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(middleSpacing)
        result.append(right)
        return result
    }
}
