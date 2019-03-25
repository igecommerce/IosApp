//
//  SaleOrder.swift
//  NetStore
//
//  Created by shaktiinfo on 12/12/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class SaleOrder: NSObject {
    var id : Int!
    var customerId : Int!
    var active  : Bool!
    var websiteId : Int!
    var currency : Int!
    var totalItems : Int!
    var totalItemsQty : Int!
    var subTotal : Float!
    var grandTotal : Float!
    var shippingAmount : Float!
    var taxAmount : Float!
    var couponCode : Int!
    var codCharges : Float!
    var paymentMethod : String!
    var createdDate: NSArray!
    var updatedDate: NSArray!
    var saleOrderItems : NSMutableArray! //SaleOrderItems
    var saleAddress : SaleAddress!
    var salePayment : String!
    
    override init()
    {
        
    }
}

class SaleOrderItems :NSObject
{
    var id : Int!
    var orderId: Int!
    var productId: Int!
    var productName: String!
    var price: Float!
    var cost: Float!
    var quantity: Int!
    var sku: String!
    var productType: String!
     var image: String!
     var imageUrl: String!
     var measurement: String!
    var createdDate: NSArray!
    var updatedDate: NSArray!
    
    override init()
    {
        
    }
}

class SaleAddress : NSObject
{
    var id : Int!
    var orderId : Int!
    var firstName : String!
    var lastName : String!
    var street : String!
    var country : String!
    var region : String!
    var area : String!
    var postCode : String!
    var createdDate : NSArray!
    var updatedDate : NSArray!
    override init()
    {
        
    }
}


