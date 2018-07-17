//
//  ErrorHandlerManager.swift
//  ShoppingListConverter
//
//  Created by Alexandru Vladut on 16/04/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import Foundation
import UIKit
public class ErrorHandlerManager {
    public static let sharedInstance = ErrorHandlerManager()
    
    private init(){
        
    }
    
    func showSimpleAlert(title:String, message:String, parentVC:UIViewController?) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (alertVC) in
            //parentVC.dismiss(animated: true, completion: nil)
        }))
        return alert
    }
    
    func showError(message:String, parentVC:UIViewController?){
        let alert = self.showSimpleAlert(title: "Error", message: message, parentVC: parentVC)
        parentVC?.present(alert, animated: true, completion: nil)
    }
    
    
}
