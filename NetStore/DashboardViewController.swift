//
//  DashboardViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 02/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var trandingCircleView: UIView!
    @IBOutlet weak var shopByCatagoryButton: UIButton!
    @IBOutlet weak var offersView: UIView!
    @IBOutlet weak var trendingView: UIView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    var reuseIdentifier = "Cell"
    var reuseIdentifier1 = "Cell1"// also enter this string as the cell identifier in the storyboard
    var items = ["Supplements", "Beauty", "Sports", "Baby", "Hair","Supplements", "Beauty", "Sports"]
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var scrollView1: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var timer = Timer()
    let homeLayout="Home"
    let trendLayout="Trending Brands"
    let amazeLayout="Amazing Offer Just for You"
    let exclusiveLayout="Exclusives"
    
    var homeImagesURLs : NSArray?
    var exclusiveImagesURLs : NSArray?
    var offersImagesURLs : NSArray?
    var trendsImagesURLs : NSArray?
    var offersImagesDesc : NSArray?
    

    var loginImages: [UIImage] = [     //Array of Banners
        UIImage(named: "image-29.png")!,
        UIImage(named: "image-31.png")!,
        UIImage(named: "image-42.png")!
    ]
    
    var itemsImagesArray: [UIImage] = [UIImage(named:"image-32.png")!,UIImage(named:"image-33.png")!,UIImage(named:"image-34.png")!,UIImage(named:"image-35.png")!,UIImage(named:"image-32.png")!,UIImage(named:"image-33.png")!,UIImage(named:"image-34.png")!,UIImage(named:"image-35.png")!]
    
    var array2: [UIImage] = [
        UIImage(named: "image-29.png")!,
        UIImage(named: "image-31.png")!,
        UIImage(named: "image-42.png")!,
        UIImage(named: "image-29.png")!,
    ]
    
    var trendingArray: [UIImage] = [
        UIImage(named: "image-37.png")!,
        UIImage(named: "image-38.png")!,
        UIImage(named: "image-39.png")!,
        UIImage(named: "image-40.png")!,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate?.currentController = self
        
        if let cid = Commons.getStringProperty(DataManager.strAddrId) {
            DataManager.addressId =  Int((cid as? String)!) //userService.getDefaultAddressIdFromLocal()
        }
        
        mainScrollView.contentSize = CGSize(width:offersView.frame.size.width, height:trendingView.frame.origin.y + trendingView.frame.size.height + 220)
        
        DispatchQueue.main.async {
            commons.showActivityIndicator()
             productService.getBanners()
            //read quote for product exist
            if (appDelegate?.user.quoteId != nil)
            {
             productService.readCartQuote(0, appDelegate?.user.quoteId)
            }
            
            
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadBannerData()
    {
        //get all banner related images
        homeImagesURLs = productService.getBannerImageURLS(homeLayout)
        exclusiveImagesURLs=productService.getBannerImageURLS(exclusiveLayout)
        offersImagesURLs = productService.getBannerImageURLS(amazeLayout)
        trendsImagesURLs = productService.getBannerImageURLS(trendLayout)
        offersImagesDesc = productService.getBannerImageDesc(amazeLayout)
        
        
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        loginImages.removeAll()
        
        
        
        //for i in 0..<loginImages.count {
        for i in 0..<homeImagesURLs!.count {
            var frame = CGRect()
            frame.origin.x = view.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = scrollView.frame.size
            let subview1 = UIView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: self.view.frame.size.width, height: scrollView.frame.size.height))
            let imageView2 = UIImageView()
            // let image2 = loginImages[i]
            imageView2.frame = subview1.frame
            //  imageView2.image = image2
            imageView2.load(url: URL(string: homeImagesURLs![i] as! String)!)
            
            //image click
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView2.isUserInteractionEnabled = true
            imageView2.addGestureRecognizer(tapGestureRecognizer)
            
            scrollView.addSubview(imageView2)
            
            
            
            
        }
        scrollView1.contentSize = CGSize(width: self.view.frame.size.width * 4, height: self.scrollView1.frame.size.height)
        scrollView1.isPagingEnabled = true
        //for i in 0..<array2.count {
        for i in 0..<exclusiveImagesURLs!.count {
            var frame = CGRect()
            frame.origin.x = ((view.frame.size.width * CGFloat(i)) + 10)
            frame.origin.y = 0
            frame.size.width = view.frame.size.width - 20
            frame.size.height = scrollView1.frame.size.height
            let subview1 = UIView(frame: frame)
            let imageView2 = UIImageView()
            //let image2 = array2[i]
            imageView2.frame = subview1.frame
            //imageView2.image = image2
            imageView2.load(url: URL(string: exclusiveImagesURLs![i] as! String)!)
            
            //image click
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView2.isUserInteractionEnabled = true
            imageView2.addGestureRecognizer(tapGestureRecognizer)
            
            scrollView1.addSubview(imageView2)
            
            
        }
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == trendingCollectionView
        {
            // return self.trendingArray.count
            if (self.trendsImagesURLs == nil)
            {
            return 0
            }
            return self.trendsImagesURLs!.count
        }
        else
        {
            if (self.offersImagesURLs == nil)
            {
                return 0
            }
            return self.offersImagesURLs!.count
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == trendingCollectionView
        {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! TredingBrandsCollectionViewCell
           // cell.imageView.image = self.trendingArray[indexPath.item]
            cell.imageView.load(url: URL(string: trendsImagesURLs![indexPath.item] as! String)!)
            
            return cell
        }
        else
        {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //   cell.myLabel.text=self.items[indexPath.item]
        cell.myLabel.text = self.offersImagesDesc![indexPath.item] as? String
        if indexPath.item % 2 == 0
        {
            cell.imageView.backgroundColor = UIColor(red: 226.0/255.0, green: 208.0/255.0, blue: 197.0/255.0, alpha: 1.0)
        }
        else
        {
            cell.imageView.backgroundColor = UIColor(red: 202.0/255.0, green: 227.0/255.0, blue: 188.0/255.0, alpha: 1.0)
        }
//        cell.imageView.image = self.itemsImagesArray[indexPath.item].withAlignmentRectInsets(UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0))
        cell.imageView.load(url: URL(string: offersImagesURLs![indexPath.item] as! String)!)
        cell.imageView.layer.shadowColor = UIColor.lightGray.cgColor

        cell.imageView.layer.shadowOpacity = 1
        cell.imageView.layer.shadowOffset = CGSize.zero
        cell.imageView.layer.shadowRadius = 5
        cell.imageView.layer.borderWidth=1.0
        cell.imageView.layer.masksToBounds = false
        cell.imageView.layer.borderColor = UIColor.white.cgColor
            cell.imageView.layer.cornerRadius = CGFloat(roundf(Float(cell.imageView.frame.size.width / 2.0)))

        cell.imageView.clipsToBounds = true
            
            return cell
        // make cell more visible in our example project
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let BabyCareViewController = self.storyboard?.instantiateViewController(withIdentifier: "BabyCareViewController") as? BabyCareViewController
        self.navigationController?.pushViewController(BabyCareViewController!, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == trendingCollectionView
//        {
//            return CGSize(width: 170, height: 160)
//        }
//        else
//        {
//        let yourWidth = collectionView.bounds.width/4.0
//        let yourHeight = yourWidth
//
//        return CGSize(width: yourWidth, height: yourHeight)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        commons.hideActivityIndicator()
        appDelegate?.currentController = self
        appDelegate?.centerContainer.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
            self.navigationController?.navigationBar.isHidden = false
        let colorTop =  UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0).cgColor
        
        let backgroundImage = UIImageView(frame: trendingView.bounds)
        backgroundImage.image = UIImage(named: "image-36.png")
        backgroundImage.alpha = 0.30
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFit
        trendingView.insertSubview(backgroundImage, at: 0)
        
        var colors = [UIColor]()
        colors.append(UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        //create a new button
        let button = UIButton(type: .custom)
         let buttons = UIButton(type: .custom)
        //set image for button
        buttons.setImage(UIImage(named: "Netstore_Source-11.png"), for: .normal)
        buttons.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "Netstore_Source-99.png"), for: .normal)

        //add function for button
        buttons.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        //set frame
        buttons.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        
        let barButton = UIBarButtonItem(customView: button)
        let barButtons = UIBarButtonItem(customView: buttons)

        //assign button to navigationbar
        self.navigationItem.leftBarButtonItems = [barButtons,barButton]
        
        let homeImage: UIImage = UIImage(named: "Netstore_Source-09.png")!
        let frameimg: CGRect = CGRect(x:0, y:0, width:20, height:23)
        let homeButton: UIButton = UIButton(frame: frameimg)
        
        homeButton.setBackgroundImage(homeImage, for: .normal)
        homeButton.imageView?.contentMode = .scaleAspectFit
       
        
        homeButton.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
        
        homeButton.showsTouchWhenHighlighted = true
        let barButtonn: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
        
    //    barButtonn.addBadge(number: 2, withOffset: CGPoint(x: -20, y:0))
        //barButtonnaddSubview(commons.getBadge(2))
        
        self.navigationItem.rightBarButtonItem = barButtonn
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
      //  gradientLayer.frame = topBar.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        topBar.layer.insertSublayer(gradientLayer, at: 0)
//        topBar.layer.cornerRadius = 2
//        topBar.clipsToBounds = true
        
     
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextImage), userInfo: nil, repeats: true)
        
        trandingCircleView.layer.cornerRadius = 5
        if (DataManager.quoteDetailData != nil)
        {
            if (DataManager.quoteDetailData?.quoteOrderItems.count != 0)
            {
                setBadge(DataManager.quoteDetailData?.quoteOrderItems.count)
            }
        }
        
    }
    @objc func cartTapped() {
        let mycart = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController
        self.navigationController?.pushViewController(mycart!, animated: true)
    }
    func setBadge(_ val : Int!)
    {
        self.navigationItem.rightBarButtonItem?.addBadge(number: val, withOffset: CGPoint(x: -10, y:0))
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let prdView = appDelegate?.currentController.storyboard?.instantiateViewController(withIdentifier: "Lotions_oilViewController") as? Lotions_oilViewController
        appDelegate?.currentController.navigationController?.pushViewController(prdView!, animated: true)
    }
    
    @IBAction func diebarButtonAction(_ sender: Any) {
        let MyAccountViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountViewController") as? MyAccountViewController
        self.navigationController?.pushViewController(MyAccountViewController!, animated: true)
    }
    
    @objc func buttonPressed() {
        appDelegate?.centerContainer.toggle(.left, animated: true, completion: nil)
    }
    @IBAction func shopByCatagoryButtonAction(_ sender: Any) {
        commons.showActivityIndicator()
        productService.getCategoriesFromServer()
//        let catagoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShopCatagoryViewController") as? ShopCatagoryViewController
//        self.navigationController?.pushViewController(catagoryViewController!, animated: true)
    }
    
    @objc func moveToNextImage ()
    {
        let pageWidth:CGFloat = self.view.frame.width
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.view.frame.origin.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth {
            slideToX = 0
        }
        
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    }

}
