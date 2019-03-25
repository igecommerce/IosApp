//
//  ShopCatagoryViewController.swift
//  NetStore
//
//  Created by Steve on 14/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class ShopCatagoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CatagoryHeaderViewControllerDelegate,UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchActive : Bool = false
    
    var data = [DataModal(headerName: "Care", subName: ["Baby Care","Body Care","Hair Care","Beaty Care"], isExpandable: false),
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
    
    var cat : Category!
    var scat : NSArray!
    
    var catfilt : CategoryFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate?.currentController = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // return data.count
        if (isCategoryFilter == true)
        {
            return 1;
        }
        return (DataManager.categoryData?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return data[section].subName.count
        if (isCategoryFilter == true)
        {
            if (DataManager.categoryFilterData == nil)
            {
                return 0;
            }
            return (DataManager.categoryFilterData?.count)!
        }
        
        cat = DataManager.categoryData![section] as? Category
        scat = cat.subCategories
        return (scat.count)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (isCategoryFilter == true)
        {
            return 44
        }
        
     //   if(data[indexPath.section].isExpandable)
        cat = DataManager.categoryData![indexPath.section] as? Category
        scat = cat.subCategories
      
        if (cat.isExpandable)
        {
            return 44
        }
        else
        {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (isCategoryFilter == true)
        {
            return nil
        }
        
        var addButton = UIButton()
        cat = DataManager.categoryData![section] as? Category
        scat = cat.subCategories
      //  if(data[section].isExpandable)
        if (cat.isExpandable)
        {
            let frame: CGRect = tableView.frame
            addButton = UIButton(frame: CGRect(x: frame.size.width - 40, y: 10, width: 25, height: 25))
            addButton.setImage(UIImage(named: "icons8-subtract-26.png"), for: .normal)
        }
        else
        {
            let frame: CGRect = tableView.frame
            addButton = UIButton(frame: CGRect(x: frame.size.width - 40, y: 10, width: 30, height: 30))
            addButton.setImage(UIImage(named: "Netstore_Source-15"), for: .normal)
        }
        
        let header = CatagoryHeaderViewController()
       // header.customInit(title: data[section].headerName!, section: section, delegate: self)
         header.customInit(title: cat.categoryName!, section: section, delegate: self)
        header.addSubview(addButton)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        if (isCategoryFilter == true)
        {
            catfilt = DataManager.categoryFilterData![indexPath.row] as? CategoryFilter
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.textLabel?.text = "\(catfilt!.name!)"
            return cell
            
        }
        
        cat = DataManager.categoryData![indexPath.section] as? Category
        scat = cat.subCategories
       
        //cell.textLabel?.text = "     \(data[indexPath.section].subName[indexPath.row])"
        let sc = scat[indexPath.row] as? Category
        cell.textLabel?.text = "      \(sc!.categoryName!)"
        //cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12.0)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (isCategoryFilter == true)
        {
            catfilt = DataManager.categoryFilterData![indexPath.row] as? CategoryFilter
            
            selCat = Category()
            selCat.categoryId = catfilt.categoryId
            selCat.categoryName = catfilt.name
        }
        else
        {
            selCat = DataManager.categoryData![indexPath.row] as! Category
        }
        print("sel category: \(selCat.categoryId!)")
        let prodListView = self.storyboard?.instantiateViewController(withIdentifier: "Lotions_oilViewController") as? Lotions_oilViewController
        self.navigationController?.pushViewController(prodListView!, animated: true)
    }
    func toggleSelection(header: CatagoryHeaderViewController , section: Int)
    {
        cat = DataManager.categoryData![section] as? Category
        scat = cat.subCategories
        //data[section].isExpandable  = !data[section].isExpandable
        cat.isExpandable  = !cat.isExpandable
        tableView.reloadSections([section], with: .automatic)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        commons.hideActivityIndicator()
        appDelegate?.currentController = self
        //pls enable this.. disabled temporirily
        //appDelegate?.centerContainer.openDrawerGestureModeMask = []
        self.navigationController?.navigationBar.isHidden = false
        var colors = [UIColor]()
        colors.append(UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.title = "Shop By Category"
        
        let homeImage: UIImage = UIImage(named: "Netstore_Source-09")!
        let frameimg: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let homeButton: UIButton = UIButton(frame: frameimg)
        homeButton.setBackgroundImage(homeImage, for: .normal)
        //homeButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        homeButton.showsTouchWhenHighlighted = true
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
        
        let searchImage: UIImage = UIImage(named: "search_white.png")!
        let frameSearchImage: CGRect = CGRect(x:0, y:0, width:10, height:20)
        let searchButton: UIButton = UIButton(frame: frameSearchImage)
        searchButton.setBackgroundImage(searchImage, for: .normal)
        //searchButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        searchButton.showsTouchWhenHighlighted = true
        let searchBarButton: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        navigationItem.rightBarButtonItems = [barButton,searchBarButton]
        
        if (DataManager.quoteDetailData != nil)
        {
            if (DataManager.quoteDetailData?.quoteOrderItems.count != 0)
            {
                setBadge(DataManager.quoteDetailData?.quoteOrderItems.count)
            }
        }
    }
    func setBadge(_ val : Int!)
    {
        self.navigationItem.rightBarButtonItem?.addBadge(number: val, withOffset: CGPoint(x: -10, y:0))
    }
    @objc func cartTapped() {
        let mycart = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController
        self.navigationController?.pushViewController(mycart!, animated: true)
    }
    
//    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
//       // searchActive = true;
//    }
//
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//       // searchActive = false;
//    }
//
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//      //  searchActive = false;
//    }
//
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//      //  searchActive = false;
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // commons.showActivityIndicator()
    
        productService.getCategoriesFilterFromServer(searchText)
        
//        filtered = data.filter({ (text) -> Bool in
//            let tmp: NSString = text
//            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            return range.location != NSNotFound
//        })
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//        self.tableView.reloadData()
    }
}

