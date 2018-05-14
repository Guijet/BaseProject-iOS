//
//  UILabelTools.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-12-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

extension UILabel{
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: spacing, range: NSMakeRange(0, text.count))
        self.attributedText = attributedString
    }
    
    func createLabel(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,textColor:UIColor,fontName:String,fontSize:CGFloat,textAignment:NSTextAlignment,text:String){
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        self.textColor = textColor
        self.font = UIFont(name:fontName, size: fontSize)
        self.textAlignment = textAignment
        self.text = text
    }
}
