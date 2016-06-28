//
//  API.swift
//  QRReaderDemo
//
//  Created by B1media on 2016/6/28.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit
import Alamofire

var responseString :String?


class API: NSObject {
    
    
    
    class func getData()-> String {
        
        Alamofire.request(.GET, "https://app.shopping99.com/auth/authAccess.jsp", parameters: nil)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                responseString = response.result.description
                }
                
        }
        return "hello"
    }
    

}
