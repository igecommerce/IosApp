//
//  MyWishListViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 09/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class MyWishListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let animals: [String] = ["Johnsons Top to Toe", "Apple Bloosom", "Gentle Cleansing"]
    
    var itemsImagesArray: [UIImage] = [UIImage(named:"image-58.png")!,UIImage(named:"image-59.png")!,UIImage(named:"image-60.png")!]
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "tableViewCell"
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var clearAllButton: UIButton!
    
    @IBAction func clearAllButtonAction(_ sender: Any) {
        //        let MyCartViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController
        //        self.navigationController?.pushViewController(MyCartViewController!, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientColour(button: clearAllButton)
       
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        print("Button tapped")
    }
    
    override func viewDidLayoutSubviews() {
        gradientColour(button: clearAllButton)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        // let display = UIBarButtonItem(title: "Display", style: .plain, target: self, action: #selector(playTapped))
        self.navigationController?.navigationBar.isHidden = false
        var colors = [UIColor]()
        colors.append(UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.title = "My Wishlist"
        
        let homeImages: UIImage = UIImage(named: "backArrow")!
        let frameimgs: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let backArrow: UIButton = UIButton(frame: frameimgs)
        backArrow.setBackgroundImage(homeImages, for: .normal)
        backArrow.addTarget(self, action: #selector(gohome), for: .touchUpInside)
        backArrow.showsTouchWhenHighlighted = true
        let leftbarButton: UIBarButtonItem = UIBarButtonItem(customView: backArrow)
        
        let homeImage: UIImage = UIImage(named: "cart_with_Item")!
        let frameimg: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let homeButton: UIButton = UIButton(frame: frameimg)
        homeButton.setBackgroundImage(homeImage, for: .normal)
        homeButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        homeButton.showsTouchWhenHighlighted = true
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
        
        let searchImage: UIImage = UIImage(named: "search_white.png")!
        let frameSearchImage: CGRect = CGRect(x:0, y:0, width:10, height:20)
        let searchButton: UIButton = UIButton(frame: frameSearchImage)
        searchButton.setBackgroundImage(searchImage, for: .normal)
        searchButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        searchButton.showsTouchWhenHighlighted = true
        let searchBarButton: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        navigationItem.rightBarButtonItems = [barButton,searchBarButton]
        navigationItem.leftBarButtonItem = leftbarButton
        
        //navigationItem.rightBarButtonItem = add
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "My Orders", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
//        self.navigationController?.navigationBar.backItem?.title = "My Orders"
//        navigationItem.leftBarButtonItem?.title = "My Orders"
        // navigationItem.leftBarButtonItem = display
    }
    
    @objc func addTapped()
    {
        let MyCartViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController
        self.navigationController?.pushViewController(MyCartViewController!, animated: true)
    }
    
    @objc func gohome()
    {
       //self.dismiss(animated: true, completion: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.mainViewSetUp()
    }
    
    @objc func playTapped()
    {
        
    }
    
    func didTapCartButton(sender: AnyObject)
    {
       
    }
    
    func didTapSearchButton(sender: AnyObject)
    {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LotionsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! LotionsTableViewCell
        
        cell.imageViews.image = itemsImagesArray[indexPath.row]
        cell.myLabels.text = animals[indexPath.row]
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "AED 3.50")
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        cell.discountLabel.attributedText = attributeString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        //        let ItemsDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ItemsDetailsViewController") as? ItemsDetailsViewController
        //        self.navigationController?.pushViewController(ItemsDetailsViewController!, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // Set the spacing between sections
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
    // Make the background color show through
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.lightGray
//        return headerView
//    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

