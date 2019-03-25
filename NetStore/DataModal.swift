//
//  DataModal.swift
//  ExpandableTableView
//
//  Created by Steve on 24/08/18.
//  Copyright © 2018 kappsoft. All rights reserved.
//

import Foundation

class DataModal
{
    var headerName : String?
    var subName = [String]()
    var isExpandable : Bool = false
    
    init(headerName: String, subName: [String], isExpandable: Bool)
    {
        self.headerName = headerName
        self.subName = subName
        self.isExpandable = isExpandable
        
    }
}
