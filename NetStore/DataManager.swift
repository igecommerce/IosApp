//
//  DataManager.swift
//  NetStore
//
//  Created by shaktiinfo on 12/7/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    static let appName = "NetStore"
    static let urlSignIn = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/signin"
    static let urlSignUp = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/signup"
    static let urlBanners = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/banners"
    static let urlCategory = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/menu"
    static let urlProducts = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/relatedproducts" //?categoryId=3"
    static let urlProductDetail = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/product/single";//?productId=3"
    
     static let urlAddAddress = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/customersaddress";
    static let urlAddressList = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/fetchcustomersaddress" //?custId=56"
    
    static let urlAddCartNew = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/cart/new"
    
    static let urlAddCartUpdate = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/cart/update"
    static let urlAddCartDelete = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/cart/delete"
    static let urlCartQuoteRead = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/cart/read"  //quoteId=164
    
     static let urlSalesOrder = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/salesorders/"  //  56
    
    static let urlPlaceOrder = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/salesorder/add" //?quoteId=93
    
    //filter api
    static let urlCategoryFilter = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/categories/filter"  //  ?name=rE
    static let urlBrandFilter = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/brand/filter"  //  ?name=rE
    static let urlProductFilter = "http://167.99.153.79:8081/gaia-ecom-service/api/v1.0/product/filter" //?gender=male&categoryId=2&brandId=1&minPrice=100&maxPrice=200&rating=1"
 
    
    
    static let strAddrId = "addressId"
    
    static var quoteId : String?
    static var addressId: Int?
    static var bannersData : NSArray?
    static var categoryData : NSMutableArray?
    static var productData : NSMutableArray?
    static var productDetailData : ProductDetail?
    static var quoteDetailData : QuoteDetail?
    static var saleOrderData : NSMutableArray?
    static var addressData : NSMutableArray?
    static var brandFilterData : NSMutableArray?
    static var categoryFilterData : NSMutableArray?
    
    static var isFromDetailView : Bool! = false
    
    static let fileUserData = "userData"
    static let fileBannersData = "bannersData"
    static let fileCategoryData = "categoryData"
    static let fileProductData = "productData"
    static let fileProductDetailData = "productDetailData"
    static let fileAddressData = "addressData"
    static let fileQuoteData = "quoteData"
    
}
