//
//  PieChart.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-12-09.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

extension UIView{
    func drawSemiCircle(){
        let semiCircleLayer   = CAShapeLayer()
        //Circle Points
        let center = CGPoint (x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        let circleRadius = self.frame.size.width / 2
        let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        semiCircleLayer.path = circlePath.cgPath
        semiCircleLayer.strokeColor = UIColor.red.cgColor
        semiCircleLayer.fillColor = UIColor.blue.cgColor
        semiCircleLayer.lineWidth = 8
        semiCircleLayer.strokeStart = 0
        semiCircleLayer.strokeEnd  = 1
        self.layer.addSublayer(semiCircleLayer)
    }
}
