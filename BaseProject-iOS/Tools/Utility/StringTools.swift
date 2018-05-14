//
//  StringVerifications.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-11-26.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

extension String{
    
    func isValidPassword()->Bool{
        return self.count >= 6
    }
    
    
    func containsCaps()->Bool{
        return self.range(of: "[A-Z]", options: .regularExpression) != nil
    }
    
    func containerNumber()->Bool{
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = self.rangeOfCharacter(from: decimalCharacters)
        return decimalRange != nil
    }
    
    func verifyLenght(min:Int = 0,max:Int = 0)->Bool{
        if(min == 0){
            return self.count >= min
        }
        else if(max == 0){
            return self.count <= 30
        }
        else{
           return self.count >= min && self.count <= max
        }
        
    }
    
    func isValidEmail()->Bool{
        return NSPredicate(format:"SELF MATCHES %@","[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
    }
    
    
    func substring(from: Int,to: Int)->String {
        let sArr = Array(self.utf8)
        var result: String = ""
        for x in from...to - 1 {
            result += String(Character(UnicodeScalar(sArr[x])))
        }
        return result
    }
    
    func separate(separationNumber: Int) -> String {
        let sArr = Array(self.utf8)
        var result: String = ""
        var indexToSeparate = 0
        var charIndex = self.count - 1
        while( charIndex >= 0) {
            indexToSeparate += 1
            result = "\(String(Character(UnicodeScalar(sArr[charIndex]))))\(result)"
            if(indexToSeparate  ==  separationNumber) {
                result = " \(result)"
                indexToSeparate = 0
            }
            charIndex -= 1
            
        }
        return result
    }
    
    func stringToDate(format:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)!
    }
    
//    func dropLast(_ n: Int = 1) -> String {
//        return String(self.dropLast(n))
//    }
    
    //Format --> mm/yy
    //
    func getExpMonthFromCardFormat()->UInt{
        let arrString = self.split{$0 == "/"}.map(String.init)
        return UInt(arrString[0])!
    }
    
    //Format --> mm/yy
    //
    func getExpYearFromCardFormat()->UInt{
        let arrString = self.split{$0 == "/"}.map(String.init)
        let result = UInt("20\(arrString[1])")!
        return result
    }
    
//    var dropLast: String {
//        return dropLast()
//    }
}
