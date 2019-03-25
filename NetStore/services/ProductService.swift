//
//  ProductService.swift
//  NetStore
//
//  Created by shaktiinfo on 12/7/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class ProductService: NSObject {
    
    public func getBanners()
    {
        guard let endpointUrl = URL(string: DataManager.urlBanners) else {
            print("\(DataManager.urlBanners) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on \(DataManager.urlBanners)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlBanners)")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let array = jsonResponse as? NSArray {
                    DataManager.bannersData = array
                    for obj in array {
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            let layoutName = dict["layoutName"]
                            print(layoutName!," ")
                            if (dict["bannerImages"] as? NSArray) != nil {
                                let array2=dict["bannerImages"] as? NSArray
                                for obj2 in array2! {
                                    if let dict2 = obj2 as? NSDictionary {
                                        let bannerImg = dict2["imageUrl"]
                                        print(bannerImg!,", ")
                                    }//if
                                }//for
                            }//if
                        }//if
                    }//for
                }//if
                
                // store the output to a file
                Commons.storeToLocalFile(responseData as NSData, DataManager.fileBannersData)
                let content=NSString(data: Commons.readFromLocalFile(DataManager.fileBannersData)! as Data, encoding: String.Encoding.utf8.rawValue)
                // print(content)
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                    if let curView = appDelegate?.currentController as? DashboardViewController {
                        curView.loadBannerData()
                    }
                    //                    appDelegate?.settingRootView(.MainViewMode)
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        return
    }
    
    public func getCategoriesFromServer()
    {
        var cat : Category!
        var scat : Category!
        var subcat : NSMutableArray!
        
        isCategoryFilter = false    // global var
        
        guard let endpointUrl = URL(string: DataManager.urlCategory) else {
            print("\(DataManager.urlCategory) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on \(DataManager.urlCategory)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlCategory)")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let array = jsonResponse as? NSArray {
                    DataManager.categoryData = NSMutableArray()
                    
                    for obj in array {
                        cat = Category()
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            cat.categoryId = dict["categoryId"] as? Int
                            cat.categoryName = dict["categoryName"] as? String
                            cat.categoryUrl =  dict["categoryUrl"] as? String
                            cat.productCount = dict["productCount"] as? Int
                            cat.level = dict["level"] as? Int
                            cat.parentId = dict["parentId"] as? Int
                            cat.isExpandable = false
                            print(cat.categoryName)
                            subcat = NSMutableArray()
                            if (dict["subCategories"] as? NSArray) != nil {
                                let array2=dict["subCategories"] as? NSArray
                                for obj2 in array2! {
                                    scat = Category()
                                    if let dict2 = obj2 as? NSDictionary {
                                        scat.categoryId = dict2["categoryId"] as? Int
                                        scat.categoryName = dict2["categoryName"] as? String
                                        scat.categoryUrl =  dict2["categoryUrl"] as? String
                                        scat.productCount = dict2["productCount"] as? Int
                                        scat.level = dict2["level"] as? Int
                                        scat.parentId = dict2["parentId"] as? Int
                                        print("- ",scat.categoryName)
                                        subcat.add(scat)
                                    }//if
                                }//for
                                cat.subCategories=subcat
                                DataManager.categoryData?.add(cat)
                            }//if
                        }//if
                    }//for
                }//if
                
                // store the output to a file
                Commons.storeToLocalFile(responseData as NSData, DataManager.fileCategoryData)
                let content=NSString(data: Commons.readFromLocalFile(DataManager.fileCategoryData)! as Data, encoding: String.Encoding.utf8.rawValue)
                // print(content)
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                    let catagoryViewController = appDelegate?.currentController.storyboard?.instantiateViewController(withIdentifier: "ShopCatagoryViewController") as? ShopCatagoryViewController
                    appDelegate?.currentController.navigationController?.pushViewController(catagoryViewController!, animated: true)
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        return
    }
    public func getCategoriesFilterFromServer(_ catname : String!)
    {
        var cat : CategoryFilter!
        
        isCategoryFilter = true    // global var
        
        guard let endpointUrl = URL(string: DataManager.urlCategoryFilter + "?name=\(catname!)") else {
            print("\(DataManager.urlCategoryFilter) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling Get on \(DataManager.urlCategoryFilter)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlCategoryFilter)")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let array = jsonResponse as? NSArray {
                    DataManager.categoryFilterData = NSMutableArray()
                    
                    for obj in array {
                        cat = CategoryFilter()
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            cat.categoryId = dict["categoryId"] as? Int
                            cat.id = dict["id"] as? Int
                            cat.name =  dict["name"] as? String
                            cat.urlKey = dict["urlKey"] as? String
                            cat.img =  dict["img"] as? String
                            cat.thumnail = dict["thumnail"] as? String
                        }//if
                        DataManager.categoryFilterData?.add(cat)
                    }//for
                }//if
                
                
                //show view
                DispatchQueue.main.async {
                    // commons.hideActivityIndicator()
                    if let curView = appDelegate?.currentController as? ShopCatagoryViewController {
                        if (DataManager.categoryFilterData != nil)
                        {
                            if (DataManager.categoryFilterData?.count as Int! > 0)
                            {
                                curView.tableView.reloadData()
                            }
                        }
                       
                    }
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        return
    }
    public func getBrandFilterFromServer(_ brandName : String!)
    {
        var brand : BrandFilter!
       
        
        guard let endpointUrl = URL(string: DataManager.urlBrandFilter + "?name=\(brandName!)") else {
            print("\(DataManager.urlBrandFilter) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on \(DataManager.urlBrandFilter)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlBrandFilter)")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let array = jsonResponse as? NSArray {
                    DataManager.brandFilterData = NSMutableArray()
                    
                    for obj in array {
                        brand = BrandFilter()
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            brand.brandId = dict["brandId"] as? Int
                            brand.name = dict["name"] as? String
                            brand.status =  dict["status"] as? Int
                          
                        }//if
                        DataManager.brandFilterData?.add(brand)
                    }//for
                }//if
                
                
                //show view
                DispatchQueue.main.async {
                   // commons.hideActivityIndicator()
                    if let curView = appDelegate?.currentController as? Lotions_oilViewController {
                        if (DataManager.brandFilterData != nil)
                        {
                            if (DataManager.brandFilterData?.count as Int! > 0)
                            {
                               
                               curView.tblBrandsView.reloadData()
                            }
                        }
                      
                    }
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        return
    }
    public func getProductListFromServer(_ categoryId : Int!)
    {
        var prd : Product!
        
        guard let endpointUrl = URL(string: DataManager.urlProducts + "?categoryId=\(categoryId ?? 0)") else {
            print("\(DataManager.urlProducts) ?categoryId=\(categoryId ?? 0) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on \(DataManager.urlProducts)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlProducts)")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let array = jsonResponse as? NSArray {
                    DataManager.productData = NSMutableArray()
                    
                    for obj in array {
                        prd = Product()
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            prd.categoryId = dict["categoryId"] as? Int
                            prd.productId = dict["productId"] as? Int
                            prd.sku =  dict["sku"] as? String
                            prd.name = dict["name"] as? String
                            prd.price = dict["price"] as? Float
                            prd.specialPrice = dict["specialPrice"] as? Float
                            
                            prd.splPriceStartDate = dict["splPriceStartDate"] as? NSArray
                            prd.splPriceEndDate = dict["splPriceEndDate"] as? NSArray
                            prd.imageUrl = dict["imageUrl"] as? String
                            prd.imageLabel = dict["imageLabel"] as? String
                            prd.stock = dict["stock"] as? Int
                            prd.stockStatus = dict["stockStatus"] as? Int
                            print(prd.name)
                            DataManager.productData?.add(prd)
                            
                        }//if
                    }//for
                }//if
                
                // store the output to a file
                Commons.storeToLocalFile(responseData as NSData, DataManager.fileProductData)
                let content=NSString(data: Commons.readFromLocalFile(DataManager.fileProductData)! as Data, encoding: String.Encoding.utf8.rawValue)
                // print(content)
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                    //reload data if its product list
                    if let curView = appDelegate?.currentController as? Lotions_oilViewController {
                        curView.tableView.reloadData()
                    }
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        return
    }
    //http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/product/filter?gender=male&categoryId=2&brandId=1&minPrice=100&maxPrice=200&rating=
    public func getProductListUsingFilterFromServer(_ categoryId : Int?, _ gender : String?, _ brandId : Int?, _ minPrice : Int?, _ maxPrice : Int?)
    {
        var prd : Product!
        
        var cond : String! = "?"
        if (categoryId != nil)
        {
            cond = cond + "categoryId=\(categoryId!)&"
        }
        if (gender != nil)
        {
          cond = cond + "gender=\(gender!)&"
        }
        if (brandId != nil)
        {
            cond = cond + "brandId=\(brandId!)&"
        }
        if (minPrice != nil)
        {
            cond = cond + "minPrice=\(minPrice!)&"
        }
        if (maxPrice != nil)
        {
            cond = cond + "maxPrice=\(maxPrice!)&"
        }
        
        let index = cond.index(cond.startIndex, offsetBy: cond!.count - 1 )
        cond = String(cond.prefix(upTo: index))
        print(DataManager.urlProductFilter + cond)
        guard let endpointUrl = URL(string: DataManager.urlProductFilter + cond) else {
            print("\(DataManager.urlProductFilter) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on \(DataManager.urlProductFilter)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlProductFilter)")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let array = jsonResponse as? NSArray {
                    DataManager.productData = NSMutableArray()
                    
                    for obj in array {
                        prd = Product()
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            prd.categoryId = dict["categoryId"] as? Int
                            prd.productId = dict["productId"] as? Int
                            prd.sku =  dict["sku"] as? String
                            prd.name = dict["name"] as? String
                            prd.price = dict["price"] as? Float
                            prd.specialPrice = dict["specialPrice"] as? Float
                            
                            prd.splPriceStartDate = dict["splPriceStartDate"] as? NSArray
                            prd.splPriceEndDate = dict["splPriceEndDate"] as? NSArray
                            prd.imageUrl = dict["imageUrl"] as? String
                            prd.imageLabel = dict["imageLabel"] as? String
                            prd.stock = dict["stock"] as? Int
                            prd.stockStatus = dict["stockStatus"] as? Int
                            print(prd.name)
                            DataManager.productData?.add(prd)
                            
                        }//if
                    }//for
                }//if
                
             
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                    //reload data if its product list
                    if let curView = appDelegate?.currentController as? Lotions_oilViewController {
                        if ( DataManager.productData!.count > 0)
                        {
                        curView.tableView.reloadData()
                        }
                        else{
                            Commons.showAlert("No Matched products", appDelegate?.currentController)
                        }
                    }
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        return
    }
    
    public func getProductDetailFromServer(_ productId : Int!)
    {
        var prd : ProductDetail!
        
        guard let endpointUrl = URL(string: DataManager.urlProductDetail + "?productId=\(productId ?? 0)") else {
            print("\(DataManager.urlProductDetail) ?productId=\(productId ?? 0) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on \(DataManager.urlProductDetail)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlProductDetail)")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let dict = jsonResponse as? NSDictionary {
                    DataManager.productDetailData = ProductDetail()
                    
                    
                    prd = ProductDetail()
                    
                    // Now reference the data you need using:
                    prd.id = dict["id"] as? Int
                    prd.sku = dict["sku"] as? String
                    prd.typeId =  dict["typeId"] as? Int
                    prd.websiteId = dict["websiteId"] as? Int
                    prd.createdDate = dict["createdDate"] as? NSArray
                    prd.updatedDate = dict["updatedDate"] as? NSArray
                    prd.attribute = ProductAttribute()
                    if let prdattr = dict["attribute"] as? NSDictionary {
                        prd.attribute.id = prdattr["id"] as? Int
                        prd.attribute.productId = prdattr["id"] as? Int
                        prd.attribute.id = prdattr["id"] as? Int
                        prd.attribute.productId = prdattr["productId"] as? Int
                        prd.attribute.name = prdattr["name"] as? String
                        prd.attribute.gender = prdattr["gender"] as? String
                        prd.attribute.brandId = prdattr["brandId"] as? Int
                        prd.attribute.measurement = prdattr["measurement"] as? String
                        prd.attribute.usage = prdattr["usage"] as? String
                        prd.attribute.composition = prdattr["composition"] as? String
                        prd.attribute.brandId = prdattr["brandId"] as? Int
                        prd.attribute.desc = prdattr["description"] as? String
                        prd.attribute.rating = prdattr["rating"] as? Int
                        print("Usage : " , prd.attribute.usage)
                    }
                    prd.deal = ProductDealAttribute()
                    if let dealattr = dict["deal"] as? NSDictionary {
                        prd.deal.id = dealattr["id"] as? Int
                        prd.deal.productId = dealattr["productId"] as? Int
                        prd.deal.startDate = dealattr["startDate"] as? NSArray
                        prd.deal.endDate = dealattr["endDate"] as? NSArray
                    }
                    prd.image = ProductImageAttribute()
                    if let imgattr = dict["image"] as? NSDictionary {
                        prd.image.id = imgattr[ "id"] as? Int
                        prd.image.productId = imgattr["productId"] as? Int
                        prd.image.image = imgattr["image"] as? String
                        prd.image.imageLabel = imgattr["imageLabel"] as? String
                        prd.image.thumbnail1 = imgattr["thumbnail1"] as? String
                        prd.image.thumbnailLabel1 = imgattr["thumbnailLabel1"] as? String
                        prd.image.thumbnail2 = imgattr["thumbnail2"] as? String
                        prd.image.thumbnailLabel2 = imgattr["thumbnailLabel2"] as? String
                        prd.image.thumbnail3 = imgattr["thumbnail3"] as? String
                        prd.image.thumbnailLabel3 = imgattr["thumbnailLabel3"] as? String
                        prd.image.thumbnail4 = imgattr["thumbnail4"] as? String
                        prd.image.thumbnailLabel4 = imgattr["thumbnailLabel4"] as? String
                        prd.image.smallImage = imgattr["smallImage"] as? String
                        prd.image.smallImageLabel = imgattr["smallImageLabel"] as? String
                        prd.image.position = imgattr["position"] as? Int
                        
                    }
                    prd.inventory = ProductInventory()
                    if let invattr = dict["inventory"] as? NSDictionary {
                        prd.inventory.id = invattr["id"] as? Int
                        prd.inventory.productId = invattr["productId"] as? Int
                        prd.inventory.stock = invattr["stock"] as? Int
                        prd.inventory.stockStatus = invattr["stockStatus"] as? String
                    }
                    prd.price = ProductPrice()
                    if let priceattr = dict["price"] as? NSDictionary {
                        prd.price.id = priceattr["id"] as? Int
                        prd.price.productId = priceattr["productId"] as? Int
                        prd.price.price = priceattr["price"] as? Float
                        prd.price.cost = priceattr["cost"] as? Float
                        prd.price.specialPrice = priceattr["specialPrice"] as? Float
                        prd.price.splPriceStartDate = priceattr["splPriceStartDate"] as? NSArray
                        prd.price.splPriceEndDate = priceattr["splPriceEndDate"] as? NSArray
                    }
                    
                    prd.status = ProductStatus()
                    if let statattr = dict["status"] as? NSDictionary {
                        prd.status.id = statattr["id"] as? Int
                        prd.status.productId = statattr["productId"] as? Int
                        prd.status.status = statattr["status"] as? Int
                        
                    }
                    DataManager.productDetailData = prd
                    
                    
                    
                }//if
                
                // store the output to a file
                Commons.storeToLocalFile(responseData as NSData, DataManager.fileProductDetailData)
                let content=NSString(data: Commons.readFromLocalFile(DataManager.fileProductDetailData)! as Data, encoding: String.Encoding.utf8.rawValue)
                // print(content)
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                    //reload data if its product list
                    if let curView = appDelegate?.currentController as? ItemsDetailsViewController {
                        //curView.view.setNeedsDisplay()
                        curView.loadData()
                    }
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        return
    }
    // cart up =1 addnew/first,2 = update ,3 =delete, isreplaceexist and isitemalreadyexist for existing product both false if add product
    public func addProductToCartAtServer(_ cartItem : CartItem!, _ cartOp : Int! , _ isReplaceExist : Bool! , _ isItemAlreadyExist : Bool! )
    {
        
        var qdet : QuoteDetail!
        var quoteaddr : QuoteAddress!
        var quoteItem : QuoteOrderItems!
        var urlCart : String!
        if (cartOp == 1)
        {
            urlCart = DataManager.urlAddCartNew
        }
        else if (cartOp == 2)
        {
            urlCart = DataManager.urlAddCartUpdate
        }
        else if(cartOp == 3)
        {
            urlCart = DataManager.urlAddCartDelete
        }
        
        guard let endpointUrl = URL(string: urlCart ) else {
            print("\(urlCart)  not found")
            return
        }
        //Make JSON to send to send to server
        var json = [String:Any]()
        //        "customerId": 24,
        //        "productId": 1,
        //        "quantity": 4,
        //        "websiteId": 2
        
        json["customerId"] = cartItem.customerId
        json["productId"] = cartItem.productId
        json["quantity"] = cartItem.quantity
        json["websiteId"] = cartItem.websiteId
        if (cartOp == 1)
        {
            json["addressId"] = cartItem.addressId
        }
        else if (cartOp == 2)
        {
            if (isItemAlreadyExist == true)
            {
                if (isReplaceExist == true)
                {
                    json["addQuantity"] = false
                    
                }
                else
                {
                    json["addQuantity"] = true   //update qtys
                }
            }//isItemAlreadyExist
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            
            var request = URLRequest(url: endpointUrl)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with : request) {
                (data, response, error) in
                guard error == nil else {
                    print("error calling POST on \(DataManager.urlAddCartNew)")
                    print(error!)
                    return
                }
                guard let responseData = data else {
                    print("Error: did not receive data \(DataManager.urlAddCartNew)")
                    return
                }
                
                // parse the result as JSON, since that's what the API provides
                do {
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        responseData, options: [])
                    print(jsonResponse) //Response result
                    if let dict = jsonResponse as? NSDictionary {
                        DataManager.quoteDetailData = QuoteDetail()
                        
                        
                        qdet = QuoteDetail()
                        
                        // Now reference the data you need using:
                        qdet.id = dict["id"] as? Int
                        qdet.customerId = dict["customerId"] as? Int
                        qdet.active = dict["active"] as? Bool
                        qdet.websiteId = dict["websiteId"] as? Int
                        qdet.currency = dict["currency"] as? Int
                        qdet.totalItems = dict["totalItems"] as? Int
                        qdet.totalItemsQty = dict["totalItemsQty"] as? Int
                        qdet.subTotal = dict["subTotal"] as? Float
                        qdet.grandTotal = dict["grandTotal"] as? Float
                        qdet.shippingAmount = dict["shippingAmount"] as? Float
                        qdet.taxAmount = dict["taxAmount"] as? Float
                        qdet.couponCode = dict["couponCode"] as? Int
                        qdet.codCharges = dict["codCharges"] as? Float
                        qdet.paymentMethod = dict["paymentMethod"] as? String
                        qdet.createdAt = dict["createdAt"] as? NSArray
                        qdet.updatedAt = dict["updatedAt"] as? NSArray
                        
                        qdet.quoteOrderItems = NSMutableArray()
                        if let array = dict["quoteOrderItems"] as? NSArray {
                            for item in array
                            {
                                if let itemattr = item as? NSDictionary {
                                    quoteItem = QuoteOrderItems()
                                    quoteItem.id = itemattr["id"] as? Int
                                    quoteItem.quoteId = itemattr["quoteId"] as? Int
                                    quoteItem.productId = itemattr["productId"] as? Int
                                    quoteItem.productName = itemattr["productName"] as? String
                                    quoteItem.quantity = itemattr["quantity"] as? Int
                                    quoteItem.price = itemattr["price"] as? Float
                                    quoteItem.cost = itemattr["cost"] as? Float
                                    quoteItem.sku = itemattr["sku"] as? String
                                    quoteItem.productType = itemattr["productType"] as? String
                                    quoteItem.measurement = itemattr["measurement"] as? String
                                    quoteItem.imageUrl = itemattr["imageUrl"] as? String
                                    quoteItem.createdDate = itemattr["createdDate"] as? NSArray
                                    quoteItem.updatedDate = itemattr["updatedDate"] as? NSArray
                                    qdet.quoteOrderItems.add(quoteItem)
                                    print("cart item : " , quoteItem.productName)
                                    
                                }//if
                            }//for
                        }//for
                        quoteaddr = QuoteAddress()
                        if let addrattr = dict["quoteAddress"] as? NSDictionary {
                            quoteaddr.id = addrattr["id"] as? Int
                            quoteaddr.quoteId = addrattr["quoteId"] as? Int
                            quoteaddr.firstName = addrattr["firstName"] as? String
                            quoteaddr.lastName = addrattr["lastName"] as? String
                            quoteaddr.street = addrattr["street"] as? String
                            quoteaddr.country = addrattr["country"] as? String
                            quoteaddr.region = addrattr["region"] as? String
                            quoteaddr.area = addrattr["area"] as? String
                            quoteaddr.createdDate = addrattr["createdDate"] as? NSArray
                            quoteaddr.updatedDate = addrattr["updatedDate"] as? NSArray
                        }
                        qdet.quoteAddress = quoteaddr
                        qdet.quotePayment =  dict["quotePayment"] as? String
                        
                        
                        DataManager.quoteDetailData = qdet
                        
                        
                        
                    }//if
                    
                    // store the output to a file
                    Commons.storeToLocalFile(responseData as NSData, DataManager.fileQuoteData)
                    let content=NSString(data: Commons.readFromLocalFile(DataManager.fileQuoteData)! as Data, encoding: String.Encoding.utf8.rawValue)
                    // print(content)
                    //show view
                    DispatchQueue.main.async {
                        commons.hideActivityIndicator()
                        if ( cartOp == 1 || cartOp == 2)
                        {
                        //reload data if its product list
                        if let curView = appDelegate?.currentController as? ItemsDetailsViewController {
                             curView.addOrUpdateCompletion(cartOp)
                            
                         }
                        }
                        if (cartOp == 3)  //delete
                        {
                            if let curView = appDelegate?.currentController as? MyCartViewController {
                                curView.deleteItemCompletion()
                                
                            }
                        }
                        
                    }
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }catch{
            print("error in add cart")
        }
        return
    }
    
    //if product id == 0, don't check otherwise check
    public func readCartQuote(_ productId : Int!, _ quoteId : Int!)
    {
        
        var isPrdExist : Bool!
        var qdet : QuoteDetail!
        var quoteaddr : QuoteAddress!
        var quoteItem : QuoteOrderItems!
        
        isPrdExist = false
        
        
        guard let endpointUrl = URL(string: DataManager.urlCartQuoteRead + "?quoteId=\(quoteId ?? 0)") else {
            print("\(DataManager.urlCartQuoteRead) ?quoteId=\(quoteId ?? 0) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling Get on \(DataManager.urlCartQuoteRead)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlCartQuoteRead)")
                return 
            }
            
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let dict = jsonResponse as? NSDictionary {
                    DataManager.quoteDetailData = QuoteDetail()
                    
                    
                    qdet = QuoteDetail()
                    
                    // Now reference the data you need using:
                    qdet.id = dict["id"] as? Int
                    qdet.customerId = dict["customerId"] as? Int
                    qdet.active = dict["active"] as? Bool
                    qdet.websiteId = dict["websiteId"] as? Int
                    qdet.currency = dict["currency"] as? Int
                    qdet.totalItems = dict["totalItems"] as? Int
                    qdet.totalItemsQty = dict["totalItemsQty"] as? Int
                    qdet.subTotal = dict["subTotal"] as? Float
                    qdet.grandTotal = dict["grandTotal"] as? Float
                    qdet.shippingAmount = dict["shippingAmount"] as? Float
                    qdet.taxAmount = dict["taxAmount"] as? Float
                    qdet.couponCode = dict["couponCode"] as? Int
                    qdet.codCharges = dict["codCharges"] as? Float
                    qdet.paymentMethod = dict["paymentMethod"] as? String
                    qdet.createdAt = dict["createdAt"] as? NSArray
                    qdet.updatedAt = dict["updatedAt"] as? NSArray
                    
                    qdet.quoteOrderItems = NSMutableArray()
                    if let array = dict["quoteOrderItems"] as? NSArray {
                        for item in array
                        {
                            if let itemattr = item as? NSDictionary {
                                quoteItem = QuoteOrderItems()
                                quoteItem.id = itemattr["id"] as? Int
                                quoteItem.quoteId = itemattr["quoteId"] as? Int
                                quoteItem.productId = itemattr["productId"] as? Int
                                if (productId != 0)
                                {
                                    // check if exist
                                    if (productId == quoteItem.productId)
                                    {
                                        isPrdExist = true
                                    }
                                }
                                quoteItem.productName = itemattr["productName"] as? String
                                quoteItem.quantity = itemattr["quantity"] as? Int
                                quoteItem.price = itemattr["price"] as? Float
                                quoteItem.cost = itemattr["cost"] as? Float
                                quoteItem.sku = itemattr["sku"] as? String
                                quoteItem.productType = itemattr["productType"] as? String
                                quoteItem.measurement = itemattr["measurement"] as? String
                                quoteItem.imageUrl = itemattr["imageUrl"] as? String
                                quoteItem.createdDate = itemattr["createdDate"] as? NSArray
                                quoteItem.updatedDate = itemattr["updatedDate"] as? NSArray
                                qdet.quoteOrderItems.add(quoteItem)
                                print("cart item : " , quoteItem.productName)
                                
                            }//if
                        }//for
                    }//for
                    quoteaddr = QuoteAddress()
                    if let addrattr = dict["quoteAddress"] as? NSDictionary {
                        quoteaddr.id = addrattr["id"] as? Int
                        quoteaddr.quoteId = addrattr["quoteId"] as? Int
                        quoteaddr.firstName = addrattr["firstName"] as? String
                        quoteaddr.lastName = addrattr["lastName"] as? String
                        quoteaddr.street = addrattr["street"] as? String
                        quoteaddr.country = addrattr["country"] as? String
                        quoteaddr.region = addrattr["region"] as? String
                        quoteaddr.area = addrattr["area"] as? String
                        quoteaddr.createdDate = addrattr["createdDate"] as? NSArray
                        quoteaddr.updatedDate = addrattr["updatedDate"] as? NSArray
                    }
                    qdet.quoteAddress = quoteaddr
                    qdet.quotePayment =  dict["quotePayment"] as? String
                    
                    
                    DataManager.quoteDetailData = qdet
                    
                    
                    
                }//if
                
                
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                    if (productId != 0)
                    {
                            if let curView = appDelegate?.currentController as? ItemsDetailsViewController {
                                curView.productExistCheckCompletion(isPrdExist)
                            }
                      
                        return;
                    }
                    //reload data if its cart list
                    if let curView = appDelegate?.currentController as? MyCartViewController {
                        curView.tableView.reloadData()
                    } else if let curView = appDelegate?.currentController as? DashboardViewController {
                        if (DataManager.quoteDetailData?.quoteOrderItems.count != 0)
                        {
                            curView.setBadge(DataManager.quoteDetailData?.quoteOrderItems.count)
                        }
                    }
                    return
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        
    }
    
    public func getSalesOrdersFromServer(_ customerId : Int!)
    {
        
        var isPrdExist : Bool!
        var sdet : SaleOrder!
        var saleaddr : SaleAddress!
        var saleItem : SaleOrderItems!
        
        isPrdExist = false
        
        
        guard let endpointUrl = URL(string: DataManager.urlSalesOrder + "\(customerId!)") else {
            print("\(DataManager.urlSalesOrder)\(customerId!) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling Get on \(DataManager.urlSalesOrder)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlSalesOrder)")
                return
            }
            
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                if let arr = jsonResponse as? NSArray {
                    DataManager.saleOrderData = NSMutableArray()
                    for ordItem in arr
                    {
                        if let dict = ordItem as? NSDictionary {
                            sdet = SaleOrder()
                            
                            // Now reference the data you need using:
                            sdet.id = dict["id"] as? Int
                            sdet.customerId = dict["customerId"] as? Int
                            sdet.active = dict["active"] as? Bool
                            sdet.websiteId = dict["websiteId"] as? Int
                            sdet.currency = dict["currency"] as? Int
                            sdet.totalItems = dict["totalItems"] as? Int
                            sdet.totalItemsQty = dict["totalItemsQty"] as? Int
                            sdet.subTotal = dict["subTotal"] as? Float
                            sdet.grandTotal = dict["grandTotal"] as? Float
                            sdet.shippingAmount = dict["shippingAmount"] as? Float
                            sdet.taxAmount = dict["taxAmount"] as? Float
                            sdet.couponCode = dict["couponCode"] as? Int
                            sdet.codCharges = dict["codCharges"] as? Float
                            sdet.paymentMethod = dict["paymentMethod"] as? String
                            sdet.createdDate = dict["createdDate"] as? NSArray
                            sdet.updatedDate = dict["updatedDate"] as? NSArray
                            
                            sdet.saleOrderItems = NSMutableArray()
                            if let array = dict["saleOrderItems"] as? NSArray {
                                for item in array
                                {
                                    if let itemattr = item as? NSDictionary {
                                        saleItem = SaleOrderItems()
                                        saleItem.id = itemattr["id"] as? Int
                                        saleItem.orderId = itemattr["orderId"] as? Int
                                        saleItem.productId = itemattr["productId"] as? Int
                                        saleItem.productName = itemattr["productName"] as? String
                                        saleItem.price = itemattr["price"] as? Float
                                        saleItem.cost = itemattr["cost"] as? Float
                                        saleItem.sku = itemattr["sku"] as? String
                                        saleItem.image = itemattr["image"] as? String
                                        saleItem.imageUrl = itemattr["imageUrl"] as? String
                                        saleItem.measurement = itemattr["measurement"] as? String
                                        saleItem.productType = itemattr["productType"] as? String
                                        saleItem.createdDate = itemattr["createdDate"] as? NSArray
                                        saleItem.updatedDate = itemattr["updatedDate"] as? NSArray
                                        sdet.saleOrderItems.add(saleItem)
                                        print("sale item : " , saleItem.productName)
                                        
                                    }//if
                                }//for
                            }//for
                            saleaddr = SaleAddress()
                            if let addrattr = dict["saleAddress"] as? NSDictionary {
                                saleaddr.id = addrattr["id"] as? Int
                                saleaddr.orderId = addrattr["orderId"] as? Int
                                saleaddr.firstName = addrattr["firstName"] as? String
                                saleaddr.lastName = addrattr["lastName"] as? String
                                saleaddr.street = addrattr["street"] as? String
                                saleaddr.country = addrattr["country"] as? String
                                saleaddr.region = addrattr["region"] as? String
                                saleaddr.area = addrattr["area"] as? String
                                saleaddr.createdDate = addrattr["createdDate"] as? NSArray
                                saleaddr.updatedDate = addrattr["updatedDate"] as? NSArray
                            }
                            sdet.saleAddress = saleaddr
                            sdet.salePayment =  dict["salePayment"] as? String
                           
              
                        }//if
                        DataManager.saleOrderData?.add(sdet)
                    }//for
                }//if
                
                
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                  
                        if let curView = appDelegate?.currentController as? MyOrdersViewController {
                            curView.tableView.reloadData()
                        }
                        
                        return;
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        
    }
    
    public func placeSalesOrderToServer(_ quoteId : Int!)
    {
        
        guard let endpointUrl = URL(string: DataManager.urlPlaceOrder + "?quoteId=\(quoteId!)") else {
            print("\(DataManager.urlPlaceOrder)?quoteId=\(quoteId!) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling Get on \(DataManager.urlPlaceOrder)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlPlaceOrder)")
                return
            }
            
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                guard let resData = jsonResponse as? [String: Any] else {
                    return
                }
                let msg=resData["message"] as? String
                let code=resData["code"] as? String
                print("Place Order msg: \(msg!)")
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                    if (code == "00")
                    {
                        if let curView = appDelegate?.currentController as? MyCartViewController {
                            curView.placeOrderCompletion()
                        }
                    }
                    else
                    {
                        Commons.showAlert(msg, appDelegate?.currentController)
                    }
                    
                    return;
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        
    }
    func resetQuoteToEmpty()
    {
        appDelegate?.user.quoteId = nil
        DataManager.quoteDetailData = nil
    }
    //from category list
    func getBannerImageURLS(_ typName:String!) -> NSArray?
    {
        var imgURLS : NSMutableArray!
        imgURLS = NSMutableArray()
        if let array = DataManager.bannersData as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    // Now reference the data you need using:
                    let layoutName = dict["layoutName"] as? String
                    if(layoutName == typName!)
                    {
                        print(layoutName!," ")
                        if (dict["bannerImages"] as? NSArray) != nil {
                            let array2=dict["bannerImages"] as? NSArray
                            for obj2 in array2! {
                                if let dict2 = obj2 as? NSDictionary {
                                    let bannerImg = dict2["imageUrl"]
                                    imgURLS.add(bannerImg as Any)
                                    //print(bannerImg!,", ")
                                }//if
                            }//for
                        }//if
                    }//if typ comparision layoutName == typName
                }//if
            }//for
        }//if
        return imgURLS
    }
    func getBannerImageDesc(_ typName:String!) -> NSArray?
    {
        var imgURLS : NSMutableArray!
        imgURLS = NSMutableArray()
        if let array = DataManager.bannersData as? NSArray {
            for obj in array {
                if let dict = obj as? NSDictionary {
                    // Now reference the data you need using:
                    let layoutName = dict["layoutName"] as? String
                    if(layoutName == typName!)
                    {
                        print(layoutName!," ")
                        if (dict["bannerImages"] as? NSArray) != nil {
                            let array2=dict["bannerImages"] as? NSArray
                            for obj2 in array2! {
                                if let dict2 = obj2 as? NSDictionary {
                                    let desc = dict2["description"]
                                    imgURLS.add(desc as Any)
                                    //print(bannerImg!,", ")
                                }//if
                            }//for
                        }//if
                    }//if typ comparision layoutName == typName
                }//if
            }//for
        }//if
        return imgURLS
    }
    
}
