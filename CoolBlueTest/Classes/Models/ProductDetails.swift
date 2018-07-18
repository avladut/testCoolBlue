//
//  ProductDetails.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 17/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
struct ProductDetails {
    var productID:String?
    public var productName:String = "Unknown"
    public var productText:String = "Unknown"
    
    init(dict:Dictionary<String,Any>) {
        if let productNameString = dict[Constants.JsonKeyNames.productName] as? String {
            self.productName = productNameString
        }
        if let productTextString = dict[Constants.JsonKeyNames.productText] as? String {
            self.productText = productTextString
        }
    }
}
