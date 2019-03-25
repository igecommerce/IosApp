//
//  CartItem.swift
//  NetStore
//
//  Created by shaktiinfo on 12/12/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class CartItem: NSObject
{
    var quoteId : Int!
    var customerId : Int!
    var productId : Int!
    var quantity : Int!
    var websiteId : Int!
    
    var addressId : Int?
    var addQuantity : Bool?    // true to update exist prod, false for replace
    
    override init()
    {
    
    }
}
