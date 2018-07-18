//
//  ProductDetailsVC.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 17/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblProductDescription: UILabel!
    var productID:String?
    @objc private var productDetailsVM:ProductDetailsViewModel? = nil
    
    var observers = [NSKeyValueObservation]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let productIDUnwr = self.productID {
            initProductViewModel(productID: productIDUnwr, httpManager:  HTTPRequestManager(baseUrlString: Constants.URLS.baseURLString))
            requestProductDetails(productID: productIDUnwr)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initProductViewModel(productID:String, httpManager:HTTPRequestAPI) {
        self.productDetailsVM = ProductDetailsViewModel(productID: productID, httpManager: httpManager)
        //add observer
        
        let observationForName = productDetailsVM?.observe(\ProductDetailsViewModel.strProductName) { (model, change) in
            self.lblProductName.text = String(model.strProductName)
        }
        let observationForText = productDetailsVM?.observe(\ProductDetailsViewModel.strProductText) { (model, change) in
            self.lblProductDescription.text = String(model.strProductText)
        }
        observers.append(observationForName!)
        observers.append(observationForText!)
    }
    
    func requestProductDetails(productID:String){
        productDetailsVM?.requestProductDetailsWithID(productID: productID)
    }

}
