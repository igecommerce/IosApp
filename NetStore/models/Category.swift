//
//  Category.swift
//  NetStore
//
//  Created by shaktiinfo on 12/8/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class Category: NSObject {

    var categoryId : Int!
    var categoryName : String!
    var categoryUrl : String!
    var level : Int!
    var productCount : Int!
    var parentId : Int!
    var subCategories :NSArray?
    
    var isExpandable : Bool!
    override init()
    {
        
    }
    
}
