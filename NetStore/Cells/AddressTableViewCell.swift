//
//  AddressTableViewCell.swift
//  NetStore
//
//  Created by shaktiinfo on 12/10/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnSel: UIButton!
   
    @IBOutlet weak var tvwfname: UILabel!
    @IBOutlet weak var tvwlname: UILabel!
 
    @IBOutlet weak var tvwStreet: UILabel!
    
    @IBOutlet weak var tvwPost: UILabel!
    @IBOutlet weak var tvwCntry: UILabel!
    @IBOutlet weak var tvwRegion: UILabel!
  
    var isChecked: Bool!
   
    override func setSelected(_ selected: Bool, animated: Bool) {
      
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
