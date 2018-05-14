//
//  NSNumberTools.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-02-25.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit

extension NSNumber{
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}
