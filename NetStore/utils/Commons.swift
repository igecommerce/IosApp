//
//  Commons.swift
//  NetStore
//
//  Created by shaktiinfo on 12/7/18.
//  Copyright © 2018 Murugan. All rights reserved.
//

import UIKit

class Commons: NSObject {
    
    static func showAlert(_ msg:String!, _ parent:UIViewController!)
    {
        let alertController = UIAlertController(title: DataManager.appName, message: msg, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("");
        }
        alertController.addAction(action1)
        parent.present(alertController, animated: true, completion: nil)
    }
    static func showUIController(_ view:UIViewController!,_ parent:UIViewController!)
    {
        parent.navigationController?.pushViewController(view, animated: true)
    }
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    static func storeToLocalFile(_ data:NSData!, _ fname : String!)
    {
        let filename = getDocumentsDirectory().appendingPathComponent(fname!)
        data.write(to: filename, atomically: true)
    }
    static func readFromLocalFile(_ fname : String!) -> NSData?
    {
        //reading
        
        let filename =  getDocumentsDirectory().appendingPathComponent(fname!)
       
        do{
            let text = try String(contentsOf: filename, encoding: .utf8)
            let data = text.data(using: .utf8)
            return data as NSData?
        }
        catch {
            let nsError = error as NSError
            print("readFromLocalFile Error: ", nsError.localizedDescription)
        }
        return nil
    }
    
    static func isValidEmail(inpEmail:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: inpEmail)
    }
    
    static func saveStringProperty(_ val:String!, _ key : String!)
    {
        UserDefaults.standard.set(val!, forKey: key!)
    }
    
    static func getStringProperty(_ key : String!) -> String?
    {
        return UserDefaults.standard.string(forKey: key!)
    }
    //Progress Indicator code starts
    
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showActivityIndicator() {
        
        var uiView: UIView!
        uiView = appDelegate?.currentController.view!
        self.container.frame = uiView.frame
        self.container.center = uiView.center
        self.container.backgroundColor = UIColor.white
        self.container.alpha = 0.7
        self.container.tag = 789456123
        
        loadingView.frame = CGRect(x:0, y:0, width:80, height:80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor.black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2, y:loadingView.frame.size.height / 2);
        
        DispatchQueue.main.async {
            self.loadingView.addSubview(self.activityIndicator)
            self.container.addSubview(self.loadingView)
            uiView.addSubview(self.container)
            self.activityIndicator.startAnimating()
        }
    }
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
//        if let urlString = urlString {
//            // create NSURL instance
//            if let url = NSURL(string: urlString) {
//                // check if your application can open the NSURL instance
//                return UIApplication.shared.canOpenURL(url as URL)
//            }
//        }
//        return false
       
        let urlPath: String = urlString!
        let url: NSURL = NSURL(string: urlPath)!
        let request: URLRequest = URLRequest(url: url as URL)
        var response: URLResponse?
        do
        {
            let data = try NSURLConnection.sendSynchronousRequest(request, returning: &response) as NSData?
            if let httpResponse = response as? HTTPURLResponse {
                print("error \(httpResponse.statusCode)")
                if (httpResponse.statusCode == 200)
                {
                    return true
                }
            }
        }catch{
            
        }
        return false
    }
    
  
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator() {
        
        DispatchQueue.main.async {
            var uiView: UIView!
            uiView = appDelegate?.currentController.view!
            if let viewWithTag = uiView.viewWithTag(789456123) {
                viewWithTag.removeFromSuperview()
            }
            else {
                return
            }
        }
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    //Progress Indicator code ends
}
