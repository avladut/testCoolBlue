//
//  Constants.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 15/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation

struct Constants {
    struct JsonKeyNames {
        static let productID = "productId"
        static let productName = "productName"
        static let productText = "productText"
        static let productPrice = "salesPriceIncVat"
        static let productImage = "productImage"
        static let pageCount = "pageCount"
        static let currentPage = "currentPage"
        static let products = "products"
    }
    struct ImageNames {
        static let placeholderImage = "Placeholder"
    }
    
    struct URLS {
        static let baseURLString = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/"
        static let testURLString = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/"
    }
}

