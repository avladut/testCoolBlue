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
    dynamic public var strProductName:String = ""
    dynamic public var strProductText:String = ""
    
    private var httpManager:HTTPRequestAPI?
    private var productDetailsModel:ProductDetails? {
        willSet {
            self.strProductName = (newValue?.productName)!
            self.strProductText = (newValue?.productText)!
        }
    }
    
    init(productID:String, httpManager:HTTPRequestAPI) {
        self.productID = productID
        self.httpManager = httpManager
    }
    
    func requestProductDetailsWithID(productID:String){
        guard let manager = httpManager else {
            return
        }
        manager.requestProductDetailsWithID(productID, completion: { [weak self] (dict, error) in
            if let productDictUnwrapped = dict?["product"] as? Dictionary<String, Any> {
                self?.productDetailsModel = ProductDetails(dict: productDictUnwrapped)
            }
        })
    }
    
    
}
