//
//  ProductDetailsViewModel.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 17/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
@objcMembers class ProductDetailsViewModel:NSObject {
    var productID:String?
    dynamic public var productName:String = ""
    dynamic public var productText:String = ""
    
    init(productID:String) {
        self.productID = productID
    }
    
    func requestProductDetailsWithID(productID:String){
        NetworkRequestManager.sharedInstance.requestProductDetailsWithID(productID, completion: { [weak self] (dict, error) in
            if let productDictUnwrapped = dict?["product"] as? Dictionary<String, Any> {
                if let productNameString = productDictUnwrapped[Constants.JsonKeyNames.productName] as? String {
                    self?.productName = productNameString
                }
                if let productTextString = productDictUnwrapped[Constants.JsonKeyNames.productText] as? String {
                    self?.productText = productTextString
                }
            }
        })
    }
    
    
}
