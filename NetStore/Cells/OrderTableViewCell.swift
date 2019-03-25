//
//  OrderTableViewCell.swift
//  NetStore
//
//  Created by shaktiinfo on 12/15/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var prdName: UILabel!
    
    @IBOutlet weak var imgPrd: UIImageView!
    
    @IBOutlet weak var lblUnit: UILabel!
    
  
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnInvoice: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    // for order detail view
    
    
    @IBOutlet weak var lblUnit1: UILabel!
    @IBOutlet weak var lblPrice1: UILabel!
    @IBOutlet weak var lblPrdName1: UILabel!
    @IBOutlet weak var imgPrd1: UIImageView!
    
    
}
