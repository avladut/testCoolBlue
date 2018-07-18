//
//  File.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 18/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
class PlistManager{
    static let sharedInstance = PlistManager()
    private init () {
        
    }
    
    func getKeyFromPlist(plistName: String, key: String, bundle:Bundle) -> Any?{
        var myDict: NSDictionary?
        if let path = bundle.path(forResource: plistName, ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            // Use your dict here
            if let value = dict[key] {
                return value
            } else {
                return nil
            }
        }
        return nil
    }
}
