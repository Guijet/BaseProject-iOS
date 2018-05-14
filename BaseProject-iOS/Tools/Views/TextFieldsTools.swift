//
//  TextFieldsTools.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-12-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

extension UITextField{
    func setUpPlaceholder(color:UIColor,fontName:String,fontSize:CGFloat){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : color,NSAttributedStringKey.font : UIFont(name: fontName, size: fontSize)!])
    }
    
    func addCustomToolBar(target:UIViewController,selector:Selector){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.tintColor = UIColor().hex("#666666")
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: target, action: selector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolBar
    }
}
