//
//  ProductBasic.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 15/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
class ProductBasic {
    var productID:String?
    var productName:String?
    var productPrice:Float?
    var productImagePath:String?
    
    init(dict:Dictionary<String, Any>){
        productID = dict[Constants.JsonKeyNames.productID] as? String
        productName = dict[Constants.JsonKeyNames.productName] as? String
        productPrice = dict[Constants.JsonKeyNames.productPrice] as? Float
        productImagePath = dict[Constants.JsonKeyNames.productImage] as? String
    }
}
