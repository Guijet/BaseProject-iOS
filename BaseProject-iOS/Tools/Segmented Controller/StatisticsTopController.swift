//
//  StatisticsTopController.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-02-18.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit

protocol StatisticsTopControllerDelegate: class {
    func selectedIndexChanged(_ selectedIndex: Int)
}

//ONLY WORKING WITH 3 ITES IN TOP BAR FOR NOW (TODO: Calculate spacing and first X)
//
class StatisticsTopController: UIView {
    
    weak var delegate: StatisticsTopControllerDelegate?
    
    var SelectableItemsTitle:[String]!
    var selectedIndex = 1
    var control:UIViewController!
    let line = UIView()
    
    init(frame: CGRect,SelectableItemsTitle:[String],control:UIViewController) {
        super.init(frame: frame)
        self.control = control
        self.SelectableItemsTitle = SelectableItemsTitle
        setUpView()
    }
    
    func setUpView(){
        self.backgroundColor = UIColor.white
        if(SelectableItemsTitle.count <= 0){return}
        var startX = rw(34)
        let xIncVal = control.rw(115)
        
        var index = 0
       
        
        for x in SelectableItemsTitle{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lblTapped(sender:)))
            let lbl = UILabel()
            lbl.isUserInteractionEnabled = true
            lbl.addGestureRecognizer(tapGesture)
            lbl.frame = CGRect(x: startX, y: 0, width: control.rw(80), height: control.rh(20))
            lbl.text = x
            lbl.center.y = self.bounds.height/2
            lbl.textAlignment = .center
            lbl.tag = index
            lbl.textColor = UIColor().hex("#898989")
            lbl.font = UIFont(name: "Montserrat-Medium", size: control.rw(14))
            
            if(index == 1){
                setSelectedOnLoad(selectedView: lbl)
            }
            
            self.addSubview(lbl)
            index += 1
            startX += xIncVal
        }
    }
    
    @objc func lblTapped(sender:UITapGestureRecognizer){
        AnimateLine(view: sender.view!)
        selectedIndex = (sender.view?.tag)!
        delegate?.selectedIndexChanged(selectedIndex)
    }
    
    
    func AnimateLine(view:UIView){
        if(view.tag == selectedIndex){return}
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.line.center.x = view.center.x
        }, completion: { _ in
            self.isUserInteractionEnabled = true
        })
    }
    

    func setSelectedOnLoad(selectedView:UIView){
        
        line.frame = CGRect(x: 0, y: self.bounds.maxY - 2, width: control.rw(92), height: 2)
        line.center.x = selectedView.center.x
        line.backgroundColor = UIColor().hex("#188DC2")
        self.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
