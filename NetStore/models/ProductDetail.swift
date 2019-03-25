//
//  ProductDetail.swift
//  NetStore
//
//  Created by shaktiinfo on 12/8/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class ProductDetail: NSObject {
    
    
    
    var id : Int!
    var sku :  String!
    var typeId : Int!
    var websiteId : Int!
    var createdDate : NSArray!
    var updatedDate : NSArray!
    var attribute : ProductAttribute!
    var deal : ProductDealAttribute!
    var image : ProductImageAttribute!
    var inventory : ProductInventory!
    var price : ProductPrice!
    var status : ProductStatus!
    
    override init()
    {
        
    }
}
class  ProductAttribute : NSObject {

    var id : Int!
    var productId : Int!
    var name : String!
    var gender: String!
    var brandId : Int!
    var measurement: String!
    var usage : String!
    var composition: String!
    var desc : String!
    var rating : Int!
    
    override init()
    {
    
    }
   
    
}
class ProductDealAttribute : NSObject
{
    var id: Int!
    var productId :Int!
    var startDate:NSArray!
    var endDate : NSArray!
    override init()
    {
        
    }
}
class ProductImageAttribute : NSObject
{
    var id : Int!
    var productId : Int!
    var image : String!
    var imageLabel : String!
    var thumbnail1 : String!
    var thumbnailLabel1 : String!
    var thumbnail2 : String!
    var thumbnailLabel2 : String!
    var thumbnail3 : String!
    var thumbnailLabel3 : String!
    var thumbnail4 : String!
    var thumbnailLabel4 : String!
    var smallImage : String!
    var smallImageLabel: String!
    var position : Int!
    override init()
    {
        
    }
    
}
class ProductInventory : NSObject
{
    var id : Int!
    var productId : Int!
    var stock : Int!
    var stockStatus : String!
    
    override init()
    {
        
    }
    
}
class ProductPrice : NSObject
{
    var id : Int!
    var productId : Int!
    var price : Float!
    var cost : Float!
    var specialPrice : Float!
    var splPriceStartDate : NSArray!
    var splPriceEndDate : NSArray!
    
    override init()
    {
        
    }
}
class ProductStatus : NSObject
{
    var id : Int!
    var productId : Int!
    var status : Int!
    
    override init()
    {
        
    }
    
}
