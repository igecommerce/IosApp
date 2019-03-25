//
//  CatagoryTableViewController.swift
//  NetStore
//
//  Created by Steve on 14/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class CatagoryTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data = [DataModal(headerName: "Care", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "Health", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "Nutrition", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "Baby & Mom", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "Subliments", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "Hygiene", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "sports", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "sun Products", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "slimness", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "Exclusives", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "Offers", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false),
                DataModal(headerName: "More", subName: ["Baby Care","Body Care","Hair Care,Beaty Care"], isExpandable: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         tableView.tableFooterView = UIView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let homeImage: UIImage = UIImage(named: "Netstore_Source-09.png")!
        let frameimg: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let homeButton: UIButton = UIButton(frame: frameimg)
        homeButton.setBackgroundImage(homeImage, for: .normal)
        //homeButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        homeButton.showsTouchWhenHighlighted = true
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        if (DataManager.quoteDetailData != nil)
        {
        setBadge(DataManager.quoteDetailData?.quoteOrderItems.count)
        }
    }
     func setBadge(_ val : Int!)
    {
        self.navigationItem.rightBarButtonItem?.addBadge(number: val, withOffset: CGPoint(x: -10, y:0))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension CatagoryTableViewController : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(frame: CGRect(x:10,y:10,width:tableView.frame.size.width - 20, height: 40))
        headerView.delegate = self
        headerView.secIndex = section
        headerView.button.setTitle(data[section].headerName, for: .normal)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data[section].isExpandable{
            return data[section].subName.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if data[indexPath.section].isExpandable
        {
            return 40
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells")
        cell?.textLabel?.text = data[indexPath.section].subName[indexPath.row]
        return cell!
    }
}

extension CatagoryTableViewController: HeaderDelegate {
    func callHeader(idx: Int?) {
        data[idx!].isExpandable = !data[idx!].isExpandable
        tableView.reloadSections([idx!], with: .automatic)
    }
}
