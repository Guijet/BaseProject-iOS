//
//  UIScrollViewTools.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-12-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

extension UIScrollView{
    func clear() {
        for x in subviews {
            x.removeFromSuperview()
        }
    }
    
    func setContentSizeHeight(translucant: Bool) {
        var bigger: CGFloat = 0
        for x in self.subviews {
            if(x.frame.maxY > bigger) {
                bigger = x.frame.maxY
                print(x.classForCoder)
            }
        }
        let offset : CGFloat = translucant ? 0 : 64
        self.contentSize = CGSize(width: 0, height: bigger + 10 + offset)
    }
    
    func setContentSizeWidth() {
        var bigger: CGFloat = 0
        for x in self.subviews {
            if(x.frame.maxX > bigger) {
                bigger = x.frame.maxX
                print(x.classForCoder)
            }
        }
        self.contentSize = CGSize(width: bigger + 10, height: 1)
    }
}
