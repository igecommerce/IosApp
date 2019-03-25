//
//  UserService.swift
//  NetStore
//
//  Created by shaktiinfo on 12/4/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class UserService: NSObject {
    
    
    
    public func checkLogin(_ email:String!,_ pwd:String!) -> User?
    {
        var user : User?
        
        
        guard let endpointUrl = URL(string: DataManager.urlSignIn) else {
            print("Signin Url not found")
            return user
        }
        
        //Make JSON to send to send to server
        var json = [String:Any]()
        
        json["email"] = email
        json["password"] = pwd
        
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
                    print("error calling POST on \(DataManager.urlSignIn)")
                    print(error!)
                    return
                }
                guard let responseData = data else {
                    print("Error: did not receive data \(DataManager.urlSignIn)")
                    return
                }
                
                // parse the result as JSON, since that's what the API provides
                do {
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        responseData, options: [])
                    print(jsonResponse) //Response result
                    guard let userData = jsonResponse as? [String: Any] else {
                        return
                    }
                    print("\(userData)")
                    guard let customer = userData["customer"] as? [String: Any] else {
                        let msg=userData["message"] as? String
                        print("Error: \(msg!)")
                        DispatchQueue.main.async {
                        commons.hideActivityIndicator()
                        Commons.showAlert(msg,appDelegate?.currentController)
                        }
                        return
                    }
                    user = User()
                    user?.customerId = customer["customerId"] as? Int
                    user?.firstName = customer["firstName"] as? String
                    user?.lastName = customer["lastName"] as? String
                    user?.gender=customer["gender"] as? String
                    user?.email=customer["email"] as? String
                    user?.mobile=customer["mobile"] as? String
                    user?.username=customer["username"] as? String
                    user?.password=customer["password"] as? String
                    user?.active=customer["active"] as? Bool
                    user?.createdAt=customer["createdAt"] as? String
                    user?.updatedAt=customer["updatedAt"] as? String
                    user?.quoteId = customer["quoteId"] as? Int
                    print("user \(String(describing: user?.firstName))")
                    print("Quote Id : \(user?.quoteId)")
                    appDelegate?.user = user
                   // store the output to a file
                    Commons.storeToLocalFile(responseData as NSData, DataManager.fileUserData)
                    let content=NSString(data: Commons.readFromLocalFile(DataManager.fileUserData) as! Data, encoding: String.Encoding.utf8.rawValue)
                    print(content)
                    //get banners
                  //  productService.getBanners()
                    
                    // move to dashboard screen
                    DispatchQueue.main.async {
                        appDelegate?.settingRootView(.MainViewMode)
                    }
                    return
                    
                } catch let parsingError {
                    print("Error", parsingError)
                    commons.hideActivityIndicator()
                }
            }
            task.resume()
        }catch{
            return user
        }
        return user
    }
    
    public func signUp(_ userDet:User!)
    {
        let user = User()
        guard let endpointUrl = URL(string: DataManager.urlSignUp) else {
            print("Signup Url not found")
            return
        }
        
        //Make JSON to send to send to server
        var json = [String:Any]()
        
        json["email"] = userDet.email
        json["firstName"] = userDet.firstName
        json["password"] = userDet.password
        
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
                    print("error calling POST on \(DataManager.urlSignUp)")
                    print(error!)
                    return
                }
                guard let responseData = data else {
                    print("Error: did not receive data \(DataManager.urlSignUp)")
                    return
                }
                
                // parse the result as JSON, since that's what the API provides
                do {
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        responseData, options: [])
                    print(jsonResponse) //Response result
                    guard let userData = jsonResponse as? [String: Any] else {
                        return
                    }
                    print("\(userData)")
                    guard let customer = userData["customer"] as? [String: Any] else {
                        let msg=userData["message"] as? String
                        print("Error: \(msg!)")
                        DispatchQueue.main.async {
                        commons.hideActivityIndicator()
                        Commons.showAlert(msg,appDelegate?.currentController)
                        }
                        return
                    }
                    user.customerId = customer["customerId"] as? Int
                    user.firstName = customer["firstName"] as? String
                    user.firstName = customer["firstName"] as? String
                    user.lastName = customer["lastName"] as? String
                    user.gender=customer["gender"] as? String
                    user.email=customer["email"] as? String
                    user.mobile=customer["mobile"] as? String
                    user.username=customer["username"] as? String
                    user.password=customer["password"] as? String
                    user.active=customer["active"] as? Bool
                    user.createdAt=customer["createdAt"] as? String
                    user.updatedAt=customer["updatedAt"] as? String
                    print("user \(String(describing: user.firstName))")
                    appDelegate?.user = user
                    
                    // store the output to a file
                    Commons.storeToLocalFile(responseData as NSData, DataManager.fileUserData)
                    let content=NSString(data: Commons.readFromLocalFile(DataManager.fileUserData) as! Data, encoding: String.Encoding.utf8.rawValue)
                    print(content)
                   
                    //show view
                    DispatchQueue.main.async {

                        // move to login screen
                        let alertController = UIAlertController(title: DataManager.appName, message: "User Registered", preferredStyle: .alert)
                        
                        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                            dummyEmail = user.email!
                            let ViewController = appDelegate?.currentController.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
                            appDelegate?.currentController.navigationController?.pushViewController(ViewController!, animated: true)
                        }
                        alertController.addAction(action1)
                        appDelegate?.currentController.present(alertController, animated: true, completion: nil)
                        return
                    }
                    
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }catch{
            return
        }
        return
    }
    
    public func addAddressToServer(_ custId:Int!, _ fname:String!, _ lname:String!, _ stname : String!, _ ctryId : Int!, _ regId : Int!, _ areaId : Int!, _postCode : Int!)
    {
        let user = User()
        guard let endpointUrl = URL(string: DataManager.urlAddAddress) else {
            print("add Address Url not found")
            return
        }
        
        //Make JSON to send to send to server
        var json = [String:Any]()
//        "customerId": 56,
//        "firstname": "Thirumullaivayal1",
//        "lastname": "Jak Nagar1",
//        "streetname": "Kakkan Street1",
//        "countryId":1,
//        "regionId":1,
//        "areaId":1,
//        "postcode":1
        json["customerId"] = custId!
        json["lastname"] = lname!
        json["firstname"] = fname!
        json["streetname"] = stname!
        json["countryId"] = 1
        json["regionId"] = 1
        json["areaId"] = 1
        json["postcode"] = 1
        
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
                    print("error calling POST on \(DataManager.urlAddAddress)")
                    print(error!)
                    return
                }
                guard let responseData = data else {
                    print("Error: did not receive data \(DataManager.urlAddAddress)")
                    return
                }
                
                // parse the result as JSON, since that's what the API provides
                do {
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        responseData, options: [])
                    print(jsonResponse) //Response result
                    guard let addressData = jsonResponse as? [String: Any] else {
                        return
                    }
                    
                    
                    //store default address id
                    guard let addrId=addressData["id"] as? Int else {
                        DispatchQueue.main.async {
                            Commons.showAlert(addressData["message"] as? String, appDelegate?.currentController)
                            return
                        }
                        return
                    }
                    DataManager.addressId = addrId
                    print("address added ")
                  
                 
                  
                    
                    //show view
                    DispatchQueue.main.async {
                        commons.hideActivityIndicator()
                        
                        if (DataManager.isFromDetailView == true)
                        {
                            print("Default Address id : \(DataManager.addressId)")
                            DataManager.isFromDetailView = false
                            //go to detail view
                            let itemDetailView = appDelegate?.currentController.storyboard?.instantiateViewController(withIdentifier: "ItemsDetailsViewController") as? ItemsDetailsViewController
                            appDelegate?.currentController.navigationController?.pushViewController(itemDetailView!, animated: true)
                            
                            return
                        }
                        Commons.showAlert("Address Saved", appDelegate?.currentController)
                        
                        return
                    }
                    
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }catch{
            return
        }
        return
    }
    
  //get All addresses
    
    public func getAddressesFromServer(_ custId : Int!)
    {
        var addr : Address!
        
        print(" Address Url\(DataManager.urlAddressList) ?custId=\(custId!)")
        
        guard let endpointUrl = URL(string: DataManager.urlAddressList + "?custId=\(custId!)") else {
            print("\(DataManager.urlAddressList) ?custId=\(custId!) not found")
            return
        }
        var request = URLRequest(url: endpointUrl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with : request) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on \(DataManager.urlAddressList)")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data \(DataManager.urlAddressList)")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                //here dataResponse received from a network request
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                print(jsonResponse) //Response result
                guard let addressData = jsonResponse as? [[String: Any]] else {
                    return
                }
                print("\(addressData)")
//                guard let address = addressData["content"] as? [[String: Any]] else {
//                    let msg=addressData["message"] as? String
//                    print("Error: \(msg!)")
//                    DispatchQueue.main.async {
//                        Commons.showAlert(msg,appDelegate?.currentController)
//                    }
//                    return
//                }
                let address = addressData
                var isFirst : Bool!
                isFirst = true
                if let array = address as? NSArray {
                    DataManager.addressData = NSMutableArray()
                    
                    for obj in array {
                        addr = Address()
                        if let dict = obj as? NSDictionary {
                            // Now reference the data you need using:
                            addr.addressId = dict["addressId"] as? Int
                            addr.customerId = dict["custId"] as? Int
                            addr.firstname =  dict["firstname"] as? String
                            addr.lastname = dict["lastname"] as? String
                            addr.streetname = dict["streetname"] as? String
                            addr.countryId = dict["countryId"] as? Int
                            
                           addr.regionId = dict["regionId"] as? Int
                           addr.areaId = dict["areaId"] as? Int
                            addr.postcode = dict["postcode"] as? Int
                            addr.country =  dict["country"] as? String
                            addr.region = dict["region"] as? String
                            addr.areaname = dict["areaname"] as? String
                          
                           addr.links =  dict["stockStatus"] as? NSArray
                            addr.isDefault = false
                            print("Name is  " ,addr.lastname , "  " , addr.firstname)
                            DataManager.addressData?.add(addr)
                            
                            //store default address id
                            if isFirst == true
                            {
                                DataManager.addressId = addr.addressId
                                isFirst = false
                            }
                            
                        }//if
                    }//for
                }//if
                
                // store the output to a file
                Commons.storeToLocalFile(responseData as NSData, DataManager.fileAddressData)
                let content=NSString(data: Commons.readFromLocalFile(DataManager.fileAddressData)! as Data, encoding: String.Encoding.utf8.rawValue)
                // print(content)
                //show view
                DispatchQueue.main.async {
                    commons.hideActivityIndicator()
                    //reload data if its product list
                    if let curView = appDelegate?.currentController as? AddressViewController {
                       curView.tblAddressView.reloadData()
                    }
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        return
    }
    
    func getUserData() -> User?
    {
        var user : User!
        guard let data = Commons.readFromLocalFile(DataManager.fileUserData) else      {
            return nil
        }
        
        let content = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        if (content == nil)
        {
            return nil
        }
        do {
            
            let data = content?.data(using : String.Encoding.utf8.rawValue)
            let jsonResponse = try JSONSerialization.jsonObject(with:
                data!, options: [])
            print(jsonResponse) //Response result
            guard let userData = jsonResponse as? [String: Any] else {
                return nil
            }
           
            guard let customer =  userData["customer"] as? NSDictionary else {
                return nil
            }
            user = User()
            user?.customerId = customer["customerId"] as? Int
            user?.firstName = customer["firstName"] as? String
            user?.lastName = customer["lastName"] as? String
            user?.gender=customer["gender"] as? String
            user?.email=customer["email"] as? String
            user?.mobile=customer["mobile"] as? String
            user?.username=customer["username"] as? String
            user?.password=customer["password"] as? String
            user?.active=customer["active"] as? Bool
            user?.createdAt=customer["createdAt"] as? String
            user?.updatedAt=customer["updatedAt"] as? String
        
            
        } catch let parsingError {
            print("Error", parsingError)
           return nil
        }
        catch
        {
            return nil
        }
        return user
    }
    
    func getDefaultAddressIdFromLocal() -> Int?
    {
        var addr : Address!
        var addrId : Int?
        let content=NSString(data: Commons.readFromLocalFile(DataManager.fileAddressData)! as Data, encoding: String.Encoding.utf8.rawValue)
        if (content == nil)
        {
            return nil
        }
        do {
            let data = content?.data(using : String.Encoding.utf8.rawValue)
            let jsonResponse = try JSONSerialization.jsonObject(with:
                data!, options: [])
            guard let addressData = jsonResponse as? [String: Any] else {
                return nil
            }
            let address = addressData["content"]
            
            var isFirst : Bool!
            isFirst = true
            if let array = address as? NSArray {
                DataManager.addressData = NSMutableArray()
                
                for obj in array {
                    addr = Address()
                    if let dict = obj as? NSDictionary {
                        // Now reference the data you need using:
                        addr.addressId = dict["addressId"] as? Int
                        addr.customerId = dict["custId"] as? Int
                        if(addr.customerId != appDelegate?.user.customerId)
                        {
                            return nil
                        }
                        addr.firstname =  dict["firstname"] as? String
                        addr.lastname = dict["lastname"] as? String
                        addr.streetname = dict["streetname"] as? String
                        addr.countryId = dict["countryId"] as? Int
                        
                        addr.regionId = dict["regionId"] as? Int
                        addr.areaId = dict["areaId"] as? Int
                        addr.postcode = dict["postcode"] as? Int
                        addr.country =  dict["country"] as? String
                        addr.region = dict["region"] as? String
                        addr.areaname = dict["areaname"] as? String
                        
                        addr.links =  dict["stockStatus"] as? NSArray
                        addr.isDefault = false
                        print("Name is  " ,addr.lastname , "  " , addr.firstname)
                        DataManager.addressData?.add(addr)
                        
                        //store default address id
                        if isFirst == true
                        {
                            addrId = addr.addressId
                            isFirst = false
                        }
                        
                    }//if
                }//for
            }//if
            
         
            
        } catch let parsingError {
            print("Error", parsingError)
            return nil
        }
        return addrId
    }
    
  
}
