//
//  Address.swift
//  NetStore
//
//  Created by shaktiinfo on 12/10/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class Address: NSObject {
    var  addressId  : Int!
    var  customerId : Int!
    var  firstname : String!
    var  lastname : String!
    var  streetname : String!
    var  countryId  : Int!
    var  regionId : Int!
    var  areaId : Int!
    var  postcode : Int!
    var  country : String!
    var  region : String!
    var  areaname : String!
    var  links : NSArray!
    
    var isDefault : Bool!
    
    override init()
    {
        
    }
    
}
