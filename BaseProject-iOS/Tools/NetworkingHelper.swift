//
//  NetworkingHelper.swift
//  BaseProject-iOS
//
//  Created by Guillaume Jette on 2018-05-14.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit

enum HttpMethod : String{
    case
    POST    = "POST",
    GET     = "GET",
    PUT     = "PUT",
    DEL     = "DELETE"
}


class NetworkingHelper{
    
    static let shared = { return NetworkingHelper() }()
    
    func getData(httpMethod:HttpMethod, completion: (_ result:[String:Any], _ error:Error?)->Void){
        
    }
    
}
