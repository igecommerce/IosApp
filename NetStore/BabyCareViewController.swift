//
//  BabyCareViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 06/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class BabyCareViewController:UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var shopByCatagoryButton: UIButton!
    @IBOutlet weak var offersView: UIView!
    @IBOutlet weak var trendingView: UIView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var trandingCircleView: UIView!
    var reuseIdentifier = "Cell"
    var reuseIdentifier1 = "Cell1"// also enter this string as the cell identifier in the storyboard
    var items = ["Johnsons Top to Toe", "Apple Bloosom", "Gentle Cleansing", "Sebamed Baby", "Apple Bloosom", "Gentle Cleansing", "Sebamed Baby", "Baby"]
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var scrollView1: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var timer = Timer()
    
    var loginImages: [UIImage] = [     //Array of Banners
        UIImage(named: "image-29.png")!,
        UIImage(named: "image-31.png")!,
        UIImage(named: "image-42.png")!
    ]
    
    var itemsImagesArray: [UIImage] = [UIImage(named:"image-48.png")!,UIImage(named:"image-50.png")!,UIImage(named:"image-49.png")!,UIImage(named:"image-51.png")!,UIImage(named:"image-48.png")!,UIImage(named:"image-50.png")!,UIImage(named:"image-49.png")!,UIImage(named:"image-51.png")!]
    
    var array2: [UIImage] = [
        UIImage(named: "image-29.png")!,
        UIImage(named: "image-31.png")!,
        UIImage(named: "image-42.png")!,
        UIImage(named: "image-29.png")!,
        ]
    
    var trendingArray: [UIImage] = [
        UIImage(named: "image-52.png")!,
        UIImage(named: "image-53.png")!,
        UIImage(named: "image-52.png")!,
        UIImage(named: "image-53.png")!,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.title = "Baby Care"
        
        mainScrollView.contentSize = CGSize(width:trendingView.frame.size.width, height:trendingView.frame.origin.y + trendingView.frame.size.height + 210)
        //offersView.frame.origin.y + offersView.frame.size.height + 230
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trendingCollectionView
        {
            return self.trendingArray.count
        }
        else
        {
            return self.items.count
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == trendingCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! TredingBrandsCollectionViewCell
            cell.imageView.image = self.trendingArray[indexPath.item]
            return cell
        }
        else
        {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.myLabel.text = self.items[indexPath.item]
//            if indexPath.item % 2 == 0
//            {
//                cell.imageView.backgroundColor = UIColor(red: 226.0/255.0, green: 208.0/255.0, blue: 197.0/255.0, alpha: 1.0)
//            }
//            else
//            {
//                cell.imageView.backgroundColor = UIColor(red: 202.0/255.0, green: 227.0/255.0, blue: 188.0/255.0, alpha: 1.0)
//            }
            cell.imageView.image = self.itemsImagesArray[indexPath.item].withAlignmentRectInsets(UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
            cell.imageView.layer.shadowColor = UIColor.lightGray.cgColor
            
            //cell.imageView.layer.shadowOpacity = 1
           // cell.imageView.layer.shadowOffset = CGSize.zero
          //  cell.imageView.layer.shadowRadius = 5
        //    cell.imageView.layer.borderWidth=1.0
          //  cell.imageView.layer.masksToBounds = false
            //cell.imageView.layer.borderColor = UIColor.white.cgColor
            //cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width/3
        //    cell.imageView.clipsToBounds = true
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "AED 3.50")
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.beforePriceLabel.attributedText = attributeString
            
            return cell
            // make cell more visible in our example project
        }
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let Lotions_oilViewController = self.storyboard?.instantiateViewController(withIdentifier: "Lotions_oilViewController") as? Lotions_oilViewController
        self.navigationController?.pushViewController(Lotions_oilViewController!, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == trendingCollectionView
//        {
//            return CGSize(width: 170, height: 160)
//        }
//        else
//        {
//            let yourWidth = collectionView.bounds.width/4.0
//            //let yourHeight = yourWidth
//
//            return CGSize(width: yourWidth, height: collectionView.frame.size.height)
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
    
    
    @IBAction func shopByCatagoryButtonAction(_ sender: Any) {
        //        let catagoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "CatagoryTableViewController") as? CatagoryTableViewController
        //        self.navigationController?.pushViewController(catagoryViewController!, animated: true)
        
        let catagoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShopCatagoryViewController") as? ShopCatagoryViewController
        self.navigationController?.pushViewController(catagoryViewController!, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate?.centerContainer.openDrawerGestureModeMask = []
        var colors = [UIColor]()
        colors.append(UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        let homeImage: UIImage = UIImage(named: "Netstore_Source-09.png")!
        let frameimg: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let homeButton: UIButton = UIButton(frame: frameimg)
        homeButton.setBackgroundImage(homeImage, for: .normal)
        homeButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        homeButton.showsTouchWhenHighlighted = true
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
        self.navigationItem.rightBarButtonItem = barButton
        //navigationItem.rightBarButtonItem = add
        let backItem = UIBarButtonItem()
        //backItem.title = "Lotions & Oils"
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.isHidden = false
        
        let colorTop =  UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0).cgColor
       
        
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * 3, height: self.scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        for i in 0..<loginImages.count {
            var frame = CGRect()
            frame.origin.x = scrollView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = scrollView.frame.size
            let subview1 = UIView(frame: frame)
            let imageView2 = UIImageView()
            let image2 = loginImages[i]
            imageView2.frame = subview1.frame
            imageView2.image = image2
            scrollView.addSubview(imageView2)
        }
        scrollView1.contentSize = CGSize(width: self.scrollView1.frame.size.width * 4, height: self.scrollView1.frame.size.height)
        scrollView1.isPagingEnabled = true
        for i in 0..<array2.count {
            var frame = CGRect()
            frame.origin.x = ((scrollView1.frame.size.width * CGFloat(i)) + 10)
            frame.origin.y = 0
            frame.size.width = scrollView1.frame.size.width - 20
            frame.size.height = scrollView1.frame.size.height
            let subview1 = UIView(frame: frame)
            let imageView2 = UIImageView()
            let image2 = array2[i]
            imageView2.frame = subview1.frame
            imageView2.image = image2
            scrollView1.addSubview(imageView2)
        }
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(moveToNextImage), userInfo: nil, repeats: true)
        trandingCircleView.layer.cornerRadius = 5
    }
    
    @objc func addTapped()
    {
        
    }
    
    @objc func moveToNextImage ()
    {
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth {
            slideToX = 0
        }
        
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    }
    
}

