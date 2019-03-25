//
//  MyAccountViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 09/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet var regionPickerView: UIPickerView!
    @IBOutlet var countryPickerView: UIPickerView!
    @IBOutlet var viewPickerBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarHidden(true, with: .fade)
        super.viewDidAppear(animated)
    }
    
    @IBAction func addressButtonAction(_ sender: Any) {
        let centerViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as! AddressViewController
        let centerNavController = UINavigationController(rootViewController: centerViewController)
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.centerContainer!.centerViewController = centerNavController
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
//        let AddressViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController
//        self.navigationController?.pushViewController(AddressViewController!, animated: true)
    }
    
    @IBAction func myOrdersButtonAction(_ sender: Any) {
        
        let centerViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyOrdersViewController") as! MyOrdersViewController
        let centerNavController = UINavigationController(rootViewController: centerViewController)
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.centerContainer!.centerViewController = centerNavController
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
        
//        let MyOrdersViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
//        self.navigationController?.pushViewController(MyOrdersViewController!, animated: true)
    }
    @IBAction func myWishlistButtonAction(_ sender: Any) {
        let centerViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyWishListViewController") as! MyWishListViewController
        let centerNavController = UINavigationController(rootViewController: centerViewController)
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.centerContainer!.centerViewController = centerNavController
        appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
//        let MyWishListViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyWishListViewController") as? MyWishListViewController
//        self.navigationController?.pushViewController(MyWishListViewController!, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
