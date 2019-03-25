//
//  CatagoryHeaderViewController.swift
//  NetStore
//
//  Created by Steve on 14/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

protocol CatagoryHeaderViewControllerDelegate {
     func toggleSelection(header: CatagoryHeaderViewController , section: Int)
}


class CatagoryHeaderViewController: UITableViewHeaderFooterView {

    var delegate : CatagoryHeaderViewControllerDelegate!
    var section : Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectHeaderSection))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func selectHeaderSection(gestureRecognizer: UITapGestureRecognizer)
    {
        let cell = gestureRecognizer.view as! CatagoryHeaderViewController
        delegate?.toggleSelection(header: self, section: cell.section)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customInit(title: String,section: Int,delegate: CatagoryHeaderViewControllerDelegate)
    {
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.black
        self.contentView.backgroundColor = UIColor.white
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
