//
//  NetworkRequestAPI.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 18/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
protocol HTTPRequestAPI : class {
    func searchFor(_ searchString:String, page:Int, completion: @escaping (_ response:Dictionary<String, Any>?, _ err:Error?)->Void)
    func requestProductDetailsWithID(_ productID:String, completion: @escaping (_ response:Dictionary<String, Any>?, _ err:Error?)->Void)
}
