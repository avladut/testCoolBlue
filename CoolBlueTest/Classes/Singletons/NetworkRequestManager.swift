//
//  NetworkRequestManager.swift
//
//
//  Created by Alexandru Vladut on 16/04/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
import Alamofire
public class NetworkRequestManager {
    public static let sharedInstance = NetworkRequestManager()
    
    private let baseURLString:String = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/"
    
    private init(){
        
    }
    
    public func searchFor(_ searchString:String, page:Int, completion: @escaping (_ response:Dictionary<String, Any>?, _ err:Error?)->Void) {
        let parameters:Parameters = ["query":searchString, "page" : page]
        let searchUrl:String = "\(baseURLString)search"
        Alamofire.request(searchUrl, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: nil).validate().responseJSON { (response) in
            //print (response)
            let responseDict = response.result.value as? Dictionary<String, Any>
            completion(responseDict, response.error)
            
        }
    }
    
    public func requestProductDetailsWithID(_ productID:String, completion: @escaping (_ response:Dictionary<String, Any>?, _ err:Error?)->Void) {
        
        let productUrl:String = "\(baseURLString)product/\(productID)"
        Alamofire.request(productUrl, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil).validate().responseJSON { (response) in
            //print (response)
            let responseDict = response.result.value as? Dictionary<String, Any>
            completion(responseDict, response.error)
        }
    }
}
