//
//  UIViewControllerTools.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-12-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

extension UIViewController{
    func rw(_ val: CGFloat) -> CGFloat {
        return val * (self.view.frame.width / 375)
    }
    func rh(_ val: CGFloat) -> CGFloat {
        return val * (self.view.frame.height / 667)
    }
    
    func previousView() -> UIViewController? {
        if let navbar = self.navigationController{
            let i = navbar.viewControllers.index(of: self)
            return navbar.viewControllers[i!-1]
        }
        return nil
    }
}
