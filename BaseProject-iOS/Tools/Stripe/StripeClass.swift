////
////  StripeClass.swift
////  InfluenceMe
////
////  Created by Guillaume Jette on 2018-01-25.
////  Copyright © 2018 Guillaume Jette. All rights reserved.
////
//
//import UIKit
//import Stripe
//
//class StripeClass{
//    
//    //SINGLETON OBJECT TO USE FOR CLASS
//    //
//    static let shared : StripeClass = {
//        let instance = StripeClass()
//        return instance
//    }()
//    
//    //CREAT A CARD TOKEN AND PASS THE FUNCTION TO BE MADE IN COMPLETION
//    //
//    //EXAMPLE OF HOW TO CALL FUNCTION         StripeClass.shared.getCardToken(f: printToken)
//    //
//    func getCardToken(cardNumber:String,
//                      cvc:String,
//                      expMonth:UInt,
//                      expYear:UInt,
//                      name:String,
//                      completion:@escaping (_ token:String?, _ error:Error?)->Void?){
//        
//        let client = STPAPIClient()
//        let clientCard = STPCardParams()
// 
//        clientCard.number = cardNumber
//        clientCard.cvc = cvc
//        clientCard.expYear = expYear
//        clientCard.expMonth = expMonth
//        clientCard.name = name
//        
//        
//        client.createToken(withCard: clientCard) { (token, error) in
//            if(error == nil){
//                completion(token!.tokenId,error)
//            }
//            else{
//                completion("",error)
//            }
//            
//        }
//    }
//}
