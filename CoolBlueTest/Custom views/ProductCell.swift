//
//  ProductCell.swift
//  CoolBlueTest
//
//  Created by Alexandru Vladut on 15/07/2018.
//  Copyright © 2018 Alexandru Vladut. All rights reserved.
//

import UIKit
import SDWebImage

class ProductCell: UITableViewCell {
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config (productVM:ProductViewModel){
        //TODO: Remove hardcoding
        imgProduct.image = UIImage(named: Constants.ImageNames.placeholderImage)
        if let strImgPath = productVM.productImagePath {
            imgProduct.sd_setImage(with: URL(string: strImgPath), completed: nil)
        }
        if let strProductName = productVM.productName {
            lblProductName.text = strProductName
        } else {
            lblProductName.text = "Unknown"
        }
        if let strProductPrice = productVM.productPrice {
            lblProductPrice.text = strProductPrice
        }else {
            lblProductPrice.text = "Unknown"
        }
    }

}
