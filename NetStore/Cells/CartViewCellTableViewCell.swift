//
//  CartViewCellTableViewCell.swift
//  NetStore
//
//  Created by shaktiinfo on 12/14/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class CartViewCellTableViewCell: UITableViewCell {

//    @IBOutlet weak var discountLabel: UILabel!
//    @IBOutlet weak var deliverLabel: UILabel!
//
//
//    @IBOutlet var lblSplPrice: UILabel!
//    @IBOutlet var lblUnit: UILabel!
//    @IBOutlet weak var myLabels: UILabel!
//    @IBOutlet weak var imageViews: UIImageView!
//    @IBOutlet weak var quantityValuewView: UIView!
    
    
    @IBOutlet weak var imageViews: UIImageView!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var prdName: UILabel!
    
    @IBOutlet weak var lblQty: UILabel!
    
    @IBOutlet weak var lblMinus: UIButton!
    
    @IBOutlet weak var lblPlus: UIButton!
    
   
    @IBOutlet weak var btnRemove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
