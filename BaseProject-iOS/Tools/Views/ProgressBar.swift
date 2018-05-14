//
//  ProgressBar.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-12-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class UIProgessBar : UIView {
    var colorComplete: UIColor!
    var colorUncomplete: UIColor!
    var maxValue: CGFloat!
    var value: CGFloat!
    var viewComplete: UIView!
    private var valueAccordingToAnimation: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewComplete = UIView(frame: frame)
        self.addSubview(viewComplete)
        colorUncomplete = UIColor().hex("#F0F0F0")
        colorComplete = UIColor().hex("#000000")
        self.backgroundColor = colorUncomplete
        viewComplete.backgroundColor = colorComplete
        maxValue = 100
        value = 50
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        viewComplete = UIView(frame: self.frame)
        self.addSubview(viewComplete)
        colorUncomplete = UIColor().hex("#F0F0F0")
        colorComplete = UIColor().hex("#000000")
        viewComplete.backgroundColor = colorComplete
        self.backgroundColor = colorUncomplete
        maxValue = 100
        value = 50
    }
    
    func setMaxValue(maxvalue: CGFloat) {
        self.maxValue = maxvalue
    }
    
    func setValue(value: CGFloat) {
        self.value = value
        
    }
    
    func show(animated: Bool,tick: CGFloat,f: @escaping (()->())) {
        viewComplete.backgroundColor = colorComplete
        self.viewComplete.layer.cornerRadius = self.layer.cornerRadius
        self.backgroundColor = colorUncomplete
        if(!animated) {
            viewComplete.frame = CGRect(x: 0, y: 0, width: self.frame.width * (value / maxValue), height: self.frame.height)
        } else {
            let delay = tick
            
            DispatchQueue.global(qos: .background).async {
                usleep(1000 * 100)
                var totalTick : CGFloat = 0
                while(totalTick <= 1.0) {
                    totalTick += (0.01 * delay)
                    self.valueAccordingToAnimation = (self.value * totalTick)
                    DispatchQueue.main.async {
                        self.viewComplete.frame = CGRect(x: 0, y: 0, width: self.frame.width * (self.value / self.maxValue) * totalTick, height: self.frame.height)
                        f()
                        
                    }
                    usleep(100)
                }
                self.viewComplete.frame = CGRect(x: 0, y: 0, width: self.frame.width * (self.value / self.maxValue), height: self.frame.height)
                
                
            }
        }
        
    }
    
    func getValueAccordingToAnimation() -> CGFloat {
        return valueAccordingToAnimation
    }
    
    func setCompleteColor(color: UIColor) {
        self.colorComplete = color
    }
    
    func setUncompleteColor(color: UIColor) {
        self.colorUncomplete = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
