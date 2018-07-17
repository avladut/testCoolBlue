//
//  ProductCellViewModel.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 17/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
struct ProductViewModel {
    var productID:String?
    var productName:String?
    var productPrice:String?
    var productImagePath:String?
    
    init(product:ProductBasic){
        productID = product.productID
        productName = product.productName
        if let priceUnwr = product.productPrice {
            productPrice = "\(priceUnwr) €"
        }
        productImagePath = product.productImagePath
        
    }
}
