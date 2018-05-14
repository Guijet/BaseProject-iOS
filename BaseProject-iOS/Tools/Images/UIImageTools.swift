//
//  UIImageTools.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-12-02.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

final class MemoryImage {
    static let data = MemoryImage()
    var arrayImage = [OptimizeImage]()
    
}

struct OptimizeImage {
    init(url: String,image: UIImage) {
        self.url = url
        self.image = image
    }
    var url: String
    var image : UIImage
}

var AssociatedObjectHandle: UInt8 = 0
var AssociatedObjectHandle1: UInt8 = 1
var AssociatedObjectHandle2: UInt8 = 2
private (set) var arrayImage = [UIImageView]()
extension UIImageView{
    
    
    
    var initialx:CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var initialy:CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle1) as! CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle1, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var indexInArray:Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle2) as! Int
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle2, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func resetParameter(){
        arrayImage.removeAll()
    }
    
    func addBigImageAction(){
        self.initialx = self.frame.origin.x
        self.initialy = self.frame.origin.y
        self.indexInArray = arrayImage.count + 1
        arrayImage.append(self)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showBigImage)))
    }
    
    @objc fileprivate func showBigImage(){
        let scrollview = self.superview! as! UIScrollView
        let view = scrollview.superview!
        print(self.indexInArray)
        let scale = view.frame.width / self.frame.width
        let midx = view.frame.midX - (view.frame.width / 2)
        let midy = (view.frame.midY - ((self.frame.height * scale) / 2) - 64) + scrollview.contentOffset.y
        
        self.layer.zPosition = 1
        if scale == 1{
            UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.frame.origin.x = self.initialx
                self.frame.origin.y = self.initialy
                self.layer.cornerRadius = 6
                //self.unhideEveryThing(view: view, scrollview: scrollview)
                self.changeBackground(view: view)
            }, completion: { _ in
                scrollview.isScrollEnabled = true
                let swipedown =  UISwipeGestureRecognizer(target: self, action: #selector(self.showBigImage))
                swipedown.direction = .down
                self.removeGestureRecognizer(swipedown)
                let swipeleft =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftArray))
                swipeleft.direction = .left
                self.removeGestureRecognizer(swipeleft)
                let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightArray))
                swipeRight.direction = .right
                self.removeGestureRecognizer(swipeRight)
            })
        }else{
            UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.frame.origin.x = midx
                self.frame.origin.y = midy
                self.layer.cornerRadius = 0
                //self.hideEveryThing(view: view, scrollview: scrollview)
                self.changeBackground(view: view)
            }, completion: { _ in
                scrollview.isScrollEnabled = false
                let swipedown =  UISwipeGestureRecognizer(target: self, action: #selector(self.showBigImage))
                swipedown.direction = .down
                self.addGestureRecognizer(swipedown)
                let swipeleft =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftArray))
                swipeleft.direction = .left
                self.addGestureRecognizer(swipeleft)
                let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightArray))
                swipeRight.direction = .right
                self.addGestureRecognizer(swipeRight)
            })
        }
    }
    
    @objc fileprivate func ReturnToOrigin(){
        let scrollview = self.superview! as! UIScrollView
        let view = scrollview.superview!
        let scale = view.frame.width / self.frame.width
        self.alpha = 0
        UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.frame.origin.x = self.initialx
            self.frame.origin.y = self.initialy
            self.layer.cornerRadius = 6
        }, completion: { _ in
            let swipedown =  UISwipeGestureRecognizer(target: self, action: #selector(self.showBigImage))
            swipedown.direction = .down
            self.removeGestureRecognizer(swipedown)
            let swipeleft =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftArray))
            swipeleft.direction = .left
            self.removeGestureRecognizer(swipeleft)
            let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightArray))
            swipeRight.direction = .right
            self.removeGestureRecognizer(swipeRight)
        })
    }
    
    @objc fileprivate func showBigImageSwipe(){
        let scrollview = self.superview! as! UIScrollView
        let view = scrollview.superview!
        let scale = view.frame.width / self.frame.width
        let midx = view.frame.midX - (view.frame.width / 2)
        let midy = (view.frame.midY - ((self.frame.height * scale) / 2) - 64) + scrollview.contentOffset.y
        self.alpha = 1
        self.layer.zPosition = 1
        
        UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.frame.origin.x = midx
            self.frame.origin.y = midy
            self.layer.cornerRadius = 0
        }, completion: { _ in
            scrollview.isScrollEnabled = false
            let swipedown =  UISwipeGestureRecognizer(target: self, action: #selector(self.showBigImage))
            swipedown.direction = .down
            self.addGestureRecognizer(swipedown)
            let swipeleft =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftArray))
            swipeleft.direction = .left
            self.addGestureRecognizer(swipeleft)
            let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightArray))
            swipeRight.direction = .right
            self.addGestureRecognizer(swipeRight)
        })
    }
    
    @objc func swipeLeftArray(){
        var index = 0
        print(arrayImage.count)
        for x in arrayImage{
            if x == self{
                if index + 1 < arrayImage.count{
                    arrayImage[index + 1].frame.origin.x = self.frame.maxX + self.frame.width
                    arrayImage[index + 1].frame.origin.y = self.frame.maxY
                    UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
                        self.frame.origin.x = self.superview!.frame.minX - self.frame.width
                        print(arrayImage[index + 1].indexInArray)
                        arrayImage[index + 1].showBigImageSwipe()
                    }, completion: {_ in
                        self.ReturnToOrigin()
                    })
                }
            }
            index += 1
        }
    }
    
    @objc func swipeRightArray(){
        var index = 0
        print(arrayImage.count)
        for x in arrayImage{
            if x == self{
                if index - 1 >= 0{
                    arrayImage[index - 1].frame.origin.x = self.frame.minX - self.frame.width
                    arrayImage[index - 1].frame.origin.y = self.frame.minY
                    UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
                        self.frame.origin.x = self.superview!.frame.maxX + self.frame.width
                        print(arrayImage[index - 1].indexInArray)
                        arrayImage[index - 1].showBigImageSwipe()
                    }, completion: {_ in
                        self.ReturnToOrigin()
                    })
                }
            }
            index += 1
        }
    }
    
    
    func changeBackground(view: UIView){
        if view.backgroundColor != .black{
            view.backgroundColor = .black
        }else{
            view.backgroundColor = .white
        }
    }
    
    func getOptimizeImageAsync(url: String){
        let refrsh = UIActivityIndicatorView()
        refrsh.frame = CGRect(x: self.bounds.midX - (self.frame.height / 2), y: self.bounds.minY, width: self.frame.height, height: self.frame.height)
        refrsh.color = UIColor().hex("#6CA743")
        self.addSubview(refrsh)
        refrsh.startAnimating()
        DispatchQueue.global(qos: .background).async {
            let image = Utility().getOptimizeImage(url: url)
            DispatchQueue.main.async {
                self.image = image
                refrsh.stopAnimating()
                refrsh.removeFromSuperview()
            }
        }
    }
    
    func getProfileImageIfAvailable(_ url:String){
        
    }
}
