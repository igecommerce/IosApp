//
//  HeaderView.swift
//  ExpandableTableView
//
//  Created by Steve on 24/08/18.
//  Copyright © 2018 kappsoft. All rights reserved.
//

import UIKit

protocol HeaderDelegate {
    func callHeader(idx:Int?)
}

class HeaderView: UIView {
    
    var secIndex : Int?
    var delegate : HeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var button : UIButton = {
        let button = UIButton(frame: CGRect(x:self.frame.origin.x, y:self.frame.origin.y, width:self.frame.width, height: self.frame.height))
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.titleLabel?.textColor = #colorLiteral(red: 0.1137254902, green: 0.1137254902, blue: 0.1137254902, alpha: 1)
        button.layer.cornerRadius = 0
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(onClickHeaderView), for: .touchUpInside)
        return button
    }()
    
    @objc func onClickHeaderView()
    {
        if let idx = secIndex {
            delegate?.callHeader(idx: idx)
        }
    }
}
