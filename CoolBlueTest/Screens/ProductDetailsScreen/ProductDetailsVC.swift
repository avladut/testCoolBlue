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
            initProductViewModel(productID: productIDUnwr)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initProductViewModel(productID:String) {
        self.productDetailsVM = ProductDetailsViewModel(productID: productID)
        //add observer
        
        let observationForName = productDetailsVM?.observe(\ProductDetailsViewModel.productName) { (model, change) in
            self.lblProductName.text = String(model.productName)
        }
        let observationForText = productDetailsVM?.observe(\ProductDetailsViewModel.productText) { (model, change) in
            self.lblProductDescription.text = String(model.productText)
        }
        observers.append(observationForName!)
        observers.append(observationForText!)
        
        productDetailsVM?.requestProductDetailsWithID(productID: productID)
    }

}
