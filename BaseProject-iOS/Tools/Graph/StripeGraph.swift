//
//  LineGraphView.swift
//  Template Project iOS
//
//  Created by Guillaume Jette on 2018-01-15.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//


import UIKit
import Foundation

class StripeGraph: UIView {
    
    @IBInspectable
    public var lineColor            :UIColor = UIColor.white
    private var control             :UIViewController!
    private var dataX               :[Int] = [Int]()
    private var dataY               :[Int] = [Int]()
    private var offsetY             :CGFloat!
    private var offsetX             :CGFloat!
    private let dataViewY           = UIView()
    private let dataViewX           = UIView()
    private let lineX               = UIView()
    private let lineY               = UIView()
    private var averageLine         :DottedLineView!
    private var MAX                 = 0
    public var tapGesure            :UITapGestureRecognizer!
    private var NBCLASSES           = 4
    
    
    
    //VIEW INIT
    //
    init(frame:CGRect,dataX:[Int],dataY:[Int],control:UIViewController) {
        super.init(frame:frame)
        self.control = control
        self.offsetY = control.rh(15)
        self.offsetX = control.rw(20)
        self.dataY = dataY
        self.dataX = dataX
        setUpVisibleGraph()
        setUpXAxis()
        setUpYAxis()
        setUpStripesOnGraph()
    }
    
    //BUILD GRAPH UI
    //
    //
    private func setUpVisibleGraph(){
        lineY.backgroundColor = lineColor
        lineY.frame = CGRect(x: offsetX * 1.5, y: offsetY, width: 2, height: (self.frame.height - (offsetY * 2)))
        self.addSubview(lineY)
        
        lineX.backgroundColor = lineColor
        lineX.frame = CGRect(x: offsetX * 1.5, y: self.frame.height - offsetY, width:  (self.frame.width - (offsetX * 2)), height:2)
        self.addSubview(lineX)
        
        averageLine = DottedLineView()
        averageLine.round = true
        averageLine.frame = CGRect(x: lineX.frame.minX, y: 0, width: lineX.frame.width, height: 2)
        averageLine.center.y = lineY.center.y
        averageLine.lineWidth = 8
        averageLine.lineColor = UIColor.white.withAlphaComponent(0.6)
        self.addSubview(averageLine)
    }
    
    //SET UP COLUMNS IN GRAPH FOR X AXIS
    //
    //
    private func setUpXAxis(){
        //CONTAINER FOR DATA
        dataViewX.frame = CGRect(x: lineX.frame.minX, y: lineX.frame.maxY + control.rh(5), width: lineX.frame.width, height: control.rh(12))
        self.addSubview(dataViewX)
        
        //SPACING BEETWEEN
        let originalSpacing = (dataViewX.frame.width/CGFloat(self.dataX.count + 1))
        
        if(self.dataX.count > 0){
            var toX:CGFloat = originalSpacing
            var index = 1
            for x in self.dataX{
                let lbl = UILabel()
                lbl.accessibilityIdentifier = "lblX\(index)"
                lbl.createLabel(x: 0, y: 0, width: control.rw(18), height: control.rh(12), textColor: UIColor.white, fontName: "Lato-Regular", fontSize: control.rw(9), textAignment: .center, text: String(describing: Int(x)))
                lbl.center.x = toX
                lbl.center.y = dataViewX.frame.height/2
                dataViewX.addSubview(lbl)
                toX += originalSpacing
                index += 1
            }
        }
    }
    
    //SET UP COLUMNS IN GRAPH FOR Y AXIS
    //
    //
    private func setUpYAxis(){
        dataViewY.frame = CGRect(x: lineY.frame.minX - (offsetX * 1.6), y: lineY.frame.minY, width: control.rw(30), height: lineY.frame.height)
        self.addSubview(dataViewY)
        if(self.dataY.count > 0){
            var index = 1
            let originalSpacing = dataViewY.frame.height/CGFloat(self.dataY.count)
            var toY:CGFloat = dataViewY.frame.height - rh(5)
            
            for x in getYDataTemplate(){
                
                let val = round(Double(x))
                let lbl = UILabel()
                lbl.accessibilityIdentifier = "lblY\(index)"
                lbl.createLabel(x: 0, y: 0, width: control.rw(30), height: control.rh(12),textColor: UIColor.white, fontName: "Lato-Regular", fontSize: control.rw(9), textAignment: .center, text: "\(String(describing:Int(val).roundedWithAbbreviations))")
                if(Int(val) > 2){
                    lbl.font = UIFont(name: "Lato-Regular", size: control.rw(8))
                }
                else{
                    lbl.font = UIFont(name: "Lato-Regular", size: control.rw(10))
                }
                
                lbl.center.x = dataViewY.frame.width/2
                lbl.center.y = toY
                dataViewY.addSubview(lbl)
                index += 1
                toY -= originalSpacing
            }
        }
    }
    
    //GET DATA FOR Y VIEW LEFT SIDE
    //
    //
    func getYDataTemplate()->[Int]{
        var val = 0
        var arrayDataY = [Int]()
        let amplitude = getAmplitude()
        for _ in 0...NBCLASSES{
            arrayDataY.append(val)
            val += amplitude
        }
        return arrayDataY
    }
    
    func getEtendue()->Int{
        let staticData = dataY
        MAX = staticData.reduce(Int.min, { max($0, $1) }).getCeiledValue()
        let maxValue = MAX
        let numMin = staticData.reduce(Int.max, { min($0, $1) })
        return maxValue - numMin
    }
    
    func getAmplitude()->Int{
        let amplitude = getEtendue()/NBCLASSES
        if(amplitude == 0){
            return 50
        }
        else{
            return amplitude
        }
    }
    
    //GET AVG FROM ARRAY OF INT
    //
    func getAverageFromArray(arr:[Int])->Int{
        return Int(arr.average)
    }
    
    //SET UP STRIPES ON GRAPH
    //
    //
    private func setUpStripesOnGraph(){
        
        var index = 1
        let originalSpacing = dataViewX.frame.width/CGFloat(self.dataX.count + 1)
        var toX = (originalSpacing + ((self.frame.width - dataViewX.frame.width)/1.5) + rw(3))
        
        for _ in 0...dataX.count - 1{
            let stripe = UIView()
            stripe.frame = CGRect(x: 0, y: lineX.frame.minY, width: control.rw(30), height: 0)
            stripe.center.x = toX
            //stripe.frame.origin.y -= stripe.frame.height
            stripe.accessibilityIdentifier = "Stripe"
            stripe.tag = index
            stripe.backgroundColor = .white
            self.addSubview(stripe)
            toX += originalSpacing
            index += 1
        }
    }
    
    private func getStripes()->[UIView]{
        var arr = [UIView]()
        var index = 1
        for x in self.subviews{
            if x.accessibilityIdentifier == "Stripe"{
                arr.append(x)
            }
            index += 1
        }
        return arr.sorted(by: {$0.tag < $1.tag})
    }
    
    //Animate data in
    //
    func animateGraphIn(){
        let arrayStripes = getStripes()
        var index = 0
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            for x in arrayStripes{
                if(self.dataY[index] != 0){
                    let heightVal = self.getStripeHeightFromDataY(dataY:self.dataY[index])
                    repeat{
                        if(heightVal == 0){break}
                        x.frame.origin.y -= 1
                        x.frame.size.height += 1
                        
                    }while(Int(x.frame.height) != heightVal)
                }
                index += 1
            }
        }, completion: nil)
    }
    
    
    
    //GET HEIGHT OF STRIPE WITH DATA Y
    func getStripeHeightFromDataY(dataY:Int)->Int{
        return Int(ceil((CGFloat(dataY) * lineY.frame.height)/CGFloat(MAX)))
    }
    
    //ADD TOUCH ON GRAPH TO PERFORM ACTION
    //
    public func addActionOnContainerView(target:UIViewController,action:Selector){
        tapGesure = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesure)
    }
    
    public func removeActionOnView(){
        self.removeGestureRecognizer(tapGesure)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

