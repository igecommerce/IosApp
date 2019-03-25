//
//  LotionsTableViewCell.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 07/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class LotionsTableViewCell: UITableViewCell {

    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var deliverLabel: UILabel!
    
    
    @IBOutlet var lblSplPrice: UILabel!
    @IBOutlet var lblUnit: UILabel!
    @IBOutlet weak var myLabels: UILabel!
    @IBOutlet weak var imageViews: UIImageView!
    @IBOutlet weak var quantityValuewView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
