//
//  IntTools.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-03-31.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(Int(number))"
        }
    }
    
    var ceilToThousands : Int {
        return Int(ceil(((Double(self) + 0.001) / 1000)) * 1000)
    }
    
    var ceilToHundreds : Int {
        return Int(ceil(((Double(self) + 0.001) / 100)) * 100)
    }
    
    var ceilToTens : Int {
        return Int(ceil(((Double(self) + 0.001) / 10)) * 10)
    }
    
    func getCeiledValue()->Int{
        if(self <= 100){
            return self.ceilToTens
        }
        else if(self <= 1000){
            return self.ceilToHundreds
        }
        else{
            return self.ceilToThousands
        }
    }
}
