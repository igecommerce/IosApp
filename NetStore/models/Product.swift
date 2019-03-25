//
//  Product.swift
//  NetStore
//
//  Created by shaktiinfo on 12/8/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class Product: NSObject {
    
    var categoryId : Int!
    var  productId : Int!
    var sku : String!
    var name : String!
    var price : Float!
    var specialPrice : Float!
    var splPriceStartDate : NSArray!
    var splPriceEndDate : NSArray!
    var imageUrl : String!
    var imageLabel : String!
    var stock : Int!
    var stockStatus : Int!
    
    override init()
    {
        
    }
    
}
