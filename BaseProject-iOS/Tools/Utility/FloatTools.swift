//
//  FloatTools.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-01-21.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit


extension Float {
    
    var twoDecimal: String {
        return String(format: "%.2f", self)
    }
    
    var twoDecimalCash:String{
        return String(format: "$%.2f", self)
    }
    
    func totalPriceToCentTotal()->Int{
        return Int(self*100)
    }
}
