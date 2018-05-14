//
//  Utility.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-11-11.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

class Utility {
    
    
    
    //VALIDATE IF DATE IS IN RANGE
    //
    func isDateStringInRange(firstDate:String,secondDate:String)->Bool{
        return firstDate <= secondDate
    }
    
    //Shuffle Any Arrays
    //
    func shuffle(array : [Any]) ->[Any] {
        var array = array
        for x in 0 ... array.count - 1 {
            let randomI = Int(arc4random_uniform(UInt32(array.count)))
            if(randomI != x) {
                array.swapAt(x, randomI)
            }
            
        }
        return array
    }
    
    //Verifiy if URL is valid
    //
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    //Recursive text color for
    //Used for Alerts
    //
    func recursifTextColor(rootView: UIView) {
        rootView.tintColor = .white
        rootView.layer.borderColor = UIColor.white.cgColor
        for x in rootView.subviews {
            
            recursifTextColor(rootView: x)
        }
    }
    
    //Recursive background color for
    //Used for Alerts
    //
    func recursifBackgroundColor(rootView: UIView) {
        
        for x in rootView.subviews {
            x.backgroundColor = UIColor().hex("#ECECEC")
            recursifBackgroundColor(rootView: x)
        }
        
    }
    
    //Alert with 2 Choices (Yes/No)
    //You can change titles
    //
    func alertYesNo(message: String,title: String,control: UIViewController,yesAction:(()->())?,noAction:(()->())?,titleYes: String,titleNo: String,style: UIAlertControllerStyle) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 22)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 16)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: style)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        
        refreshAlert.addAction(UIAlertAction(title: titleYes, style: .default, handler: { (action: UIAlertAction!) in
            
            refreshAlert.dismiss(animated: true, completion: nil)
            yesAction?()
        }))
        refreshAlert.addAction(UIAlertAction(title: titleNo, style: .default, handler: { (action: UIAlertAction!) in
            
            refreshAlert.dismiss(animated: true, completion: nil)
            noAction?()
        }))
        control.present(refreshAlert, animated: true, completion: nil)
    }
    
    //Alert with 2 Choices (Yes/No) + Cancel
    //You can change titles
    //
    func alertWithChoice(message: String,title: String,control: UIViewController,actionTitle1: String,actionTitle2: String,action1:(()->())?,action2:(()->())?,style: UIAlertControllerStyle) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 22)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 16)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: style)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        if actionTitle1 != "Table"{
            refreshAlert.addAction(UIAlertAction(title: actionTitle1, style: .default, handler: { (action: UIAlertAction!) in
                action1?()
                refreshAlert.dismiss(animated: true, completion: nil)
            }))
        }
        refreshAlert.addAction(UIAlertAction(title: actionTitle2, style: .default, handler: { (action: UIAlertAction!) in
            action2?()
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        })
        
        refreshAlert.addAction(cancel)
        control.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    //Alert with message and
    //Title that can be define
    //
    func alert(message: String,title: String,control:UIViewController) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 22)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 16)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        control.present(refreshAlert, animated: true, completion: nil)
    }
    
    //Alert with message and
    //Title that can be define
    //and a function that will be called at the end
    //
    func alert(message: String,title: String,control:UIViewController,f: (()->())?) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 22)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 16)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
            f?()
        }))
        
        control.present(refreshAlert, animated: true, completion: nil)
    }
    
    //,closure: (() -> Void)?
    func alert(message: String,title: String,control:UIViewController,closure: (() -> Void)?) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 22)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSAttributedStringKey.font : UIFont(name: "Lato-Regular", size: 16)!,
            NSAttributedStringKey.foregroundColor : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            refreshAlert.dismiss(animated: true, completion: nil)
            closure?()
        }))
        
        control.present(refreshAlert, animated: true, completion: nil)
    }
    
    //Get image from a URL String
    //and verify if image is stored in
    //cache before loading it from URL
    //
    //
    func getOptimizeImage(url: String) -> UIImage {
        if(!Utility().verifyUrl(urlString: url)) {
            return UIImage()
        }
        for x in MemoryImage.data.arrayImage {
            if(x.url == url) {
                return x.image
            }
        }
        do{
            var img = UIImage()
            let urll = URL(string: url)
            let dataimg = try Data(contentsOf: urll!)
            img = UIImage(data: dataimg)!
            DispatchQueue(label: "addinArray").sync {
                MemoryImage.data.arrayImage.append(OptimizeImage(url: url, image: img))
            }
            return img
        }
        catch {}
        return UIImage()
    }

    //Return a Dictionnary
    //from Json result
    //
    //Used for HTTP Request
    //
    func getJson(url:String, method:String, body:String = "",needToken:Bool = false)->HTTPResult{
        
        var finish = false
        var result: HTTPResult!
        
        DispatchQueue.global(qos:.background).async {
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = method
            
            if(method == "POST") {
                let postString = body
                request.httpBody = postString.data(using: .utf8)
            }
            else if(method == "PUT"){
                let putString = body
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpBody = putString.data(using: .utf8)
            }
            else if(method == "DELETE"){
                let deleteString = body
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpBody = deleteString.data(using: .utf8)
            }
            
            if(needToken){
                //request.addValue("Bearer \(Global.global.token)", forHTTPHeaderField: "Authorization")
            }
            
            let config = URLSessionConfiguration.default
            config.httpMaximumConnectionsPerHost = 100
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    
                    result = HTTPResult(isError: true, message: "Network error. Can not connect to the server. Please try again later.", dict: ["nil":"nil"])
                    finish = true
                    return
                }
                
                let responseText: String = String(data: data, encoding: String.Encoding.utf8)!
                print(responseText)
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    result = HTTPResult(isError: true, message: String(describing: response!), dict: ["nil":"nil"])
                }
                
                do
                {
                    if let parsedData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]{
                        result = HTTPResult(isError: false, message: "OK", dict: parsedData)
                    } else {
                        result = HTTPResult(isError: true, message: "API Errors", dict: ["nil":"nil"])
                    }
                    
                    finish = true
                }
                catch let error as NSError
                {
                    result = HTTPResult(isError: true, message: error.localizedDescription, dict: ["nil":"nil"])
                    finish = true
                }
            }
            task.resume()
            session.finishTasksAndInvalidate()
            
        }
        while(!finish) { usleep(300) }
        return result
    }
}

class HTTPResult{
    private var _isError:Bool!
    private var _message:String!
    private var _dict:[String:Any]!
    
    init(isError:Bool,message:String = "",dict:[String:Any] = ["nil":"nil"]) {
        setIsError(isError: isError)
        setMessage(message: message)
        setDict(dict: dict)
    }
    
    func setIsError(isError:Bool){
        self._isError = isError
    }
    
    func setMessage(message:String){
        self._message = message
    }
    
    func setDict(dict:[String:Any]){
        self._dict = dict
    }
    
    func getMessage()->String{
        return self._message
    }
    
    func getIsError()->Bool{
        return self._isError
    }
    
    func getDict()->[String:Any]{
        return self._dict
    }
}

extension UITabBarController {
    func setTabBarVisible(visible:Bool, duration: TimeInterval, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // animation
        UIViewPropertyAnimator(duration: duration, curve: .linear) {
            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
            self.view.frame = CGRect(x:0,y:0,width: self.view.frame.width, height: self.view.frame.height + offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
            }.startAnimation()
    }
    
    func tabBarIsVisible() ->Bool {
        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
    }
}














