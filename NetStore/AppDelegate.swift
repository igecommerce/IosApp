//
//  AppDelegate.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 02/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit
import CoreData

enum RootViewMode:Int {
    case LoginViewMode
    case MainViewMode
}

let appDelegate = UIApplication.shared.delegate as? AppDelegate
var loginViewController:ViewController!
var dashBoardViewController: DashboardViewController!

var  userService : UserService!;
var productService : ProductService!;
var commons : Commons!
var selSaleOrder : SaleOrder!
var selPrd : Product!
var selCat : Category!
var selAddr : Address!
var dummyEmail : String!
var isCategoryFilter : Bool!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentController : UIViewController!
    var centerContainer: MMDrawerController!
    var user : User!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       // Thread.sleep(forTimeInterval: 3)
        setUpGlobalUserInterface()
        settingRootView(RootViewMode.LoginViewMode)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK:- UserInterface
    func setUpGlobalUserInterface()
    {
         userService = UserService()
         productService = ProductService()
        commons = Commons()
        isCategoryFilter = false
        
        let BarButtonItemAppearance = UIBarButtonItem.appearance()//remove the back button title
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        
        self.window?.tintColor = UIColor.white//navigation bar tint color
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    func settingRootView(_ rootViewMode:RootViewMode)
    {
        switch rootViewMode
        {
        case .LoginViewMode:
           let mainStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
           
            let viewController = mainStoryBoard.instantiateViewController(withIdentifier:"ViewController") as! ViewController
            let viewNav = UINavigationController(rootViewController:viewController)
            self.currentController = viewController
//---
//            let signUpController = mainStoryBoard.instantiateViewController(withIdentifier:"SignUpViewController") as! SignUpViewController
//            let viewNav = UINavigationController(rootViewController:signUpController)
//            self.currentController = signUpController
//---
//            let itemsController = mainStoryBoard.instantiateViewController(withIdentifier:"Lotions_oilViewController") as! Lotions_oilViewController
//            let viewNav = UINavigationController(rootViewController:itemsController)
//            self.currentController = itemsController
//
//            let itemsDetController = mainStoryBoard.instantiateViewController(withIdentifier:"ItemsDetailsViewController") as! ItemsDetailsViewController
//            let viewNav = UINavigationController(rootViewController:itemsDetController)
//            self.currentController = itemsDetController

//            let addrViewController = mainStoryBoard.instantiateViewController(withIdentifier:"AddressViewController") as! AddressViewController
//            let viewNav = UINavigationController(rootViewController:addrViewController)
//            self.currentController = addrViewController
            
//            let orderViewController = mainStoryBoard.instantiateViewController(withIdentifier:"MyOrdersViewController") as! MyOrdersViewController
//                        let viewNav = UINavigationController(rootViewController:orderViewController)
//                        self.currentController = orderViewController
//
            window?.rootViewController = viewNav
            window?.makeKeyAndVisible()
            break
        case .MainViewMode:
           mainViewSetUp()
           break
        }
    }
    
    func mainViewSetUp()
    {
        var rootViewController = self.window?.rootViewController
        let mainStoryBoard: UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
        
        let mainViewController = mainStoryBoard.instantiateViewController(withIdentifier:"DashboardViewController") as! DashboardViewController
        let drawerViewController = mainStoryBoard.instantiateViewController(withIdentifier:"MyAccountViewController") as! MyAccountViewController
        
        let mainViewNav = UINavigationController(rootViewController:mainViewController)
        let drawerViewNav = UINavigationController(rootViewController:drawerViewController)
         self.currentController = mainViewController
        
        centerContainer = MMDrawerController(center: mainViewNav, leftDrawerViewController: drawerViewNav)
        centerContainer?.setMaximumLeftDrawerWidth(UIScreen.main.bounds.width - 50, animated: true, completion: nil)
        centerContainer.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
        centerContainer.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        window?.rootViewController = centerContainer
        window?.makeKeyAndVisible()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NetStore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

