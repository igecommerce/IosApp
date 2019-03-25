//
//  OrderHeaderView.swift
//  NetStore
//
//  Created by shaktiinfo on 12/15/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class OrderHeaderView: UIView {

    
   
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var lblOrdDate: UILabel!
    
    @IBOutlet weak var lblOrdId: UILabel!
    
    @IBOutlet weak var lblDeliverDate: UILabel!
    
    override init (frame : CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    private func commonInit()
    {
        Bundle.main.loadNibNamed("OrderHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
