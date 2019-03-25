//
//  Lotions&oilViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 07/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class Lotions_oilViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UISearchBarDelegate {
    
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var brandButton: UIButton!
    // Data model: These strings will be the data for the table view cells
    let animals: [String] = ["Johnsons Top to Toe", "Apple Bloosom", "Gentle Cleansing", "Sebamed Baby", "Johnsons Top to Toe", "Apple Bloosom", "Gentle Cleansing", "Sebamed Baby", "Baby", "Hair"]
    
    var itemsImagesArray: [UIImage] = [UIImage(named:"image-58.png")!,UIImage(named:"image-59.png")!,UIImage(named:"image-60.png")!,UIImage(named:"image-61.png")!,UIImage(named:"image-62.png")!,UIImage(named:"image-58.png")!,UIImage(named:"image-59.png")!,UIImage(named:"image-60.png")!,UIImage(named:"image-61.png")!,UIImage(named:"image-62.png")!]
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "tableViewCell"
    
    
    var cell = UITableViewCell()
    let myArray: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat","Horse", "Cow", "Camel", "Sheep", "Goat","Horse", "Cow", "Camel", "Sheep", "Goat","Horse", "Cow", "Camel", "Sheep", "Goat"]
    let cellReuseIdentifiers = "tablecell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    //private var myTableView: UITableView!
 //   @IBOutlet var mytableView: UITableView!
    
    @IBOutlet var brandView: UIView!
    @IBOutlet var priceRangingView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var applyButton1: UIButton!
    @IBOutlet weak var applyButton2: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var clearButton1: UIButton!
    @IBOutlet weak var clearButton2: UIButton!
    @IBOutlet var sliderView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    var product : Product!
    
    //Price ranging View
    
    @IBOutlet weak var btnPriceLtoH: UIButton!
    
    @IBOutlet weak var btnPriceNew: UIButton!
    @IBOutlet weak var btnPriceBest: UIButton!
    @IBOutlet weak var btnPriceHtoL: UIButton!
    //brand search
    
    var brand : BrandFilter!
    var selBrand : BrandFilter!
    @IBOutlet weak var tblBrandsView: UITableView!
    @IBOutlet weak var srchBrand: UISearchBar!
    
    
    //slider price controls
    @IBOutlet weak var sliderPriceRange: UISlider!
    
    @IBOutlet weak var lblMinVal: UILabel!
    
    @IBOutlet weak var lblMaxVal: UILabel!
    
    @IBOutlet weak var lblCurVal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        appDelegate?.currentController = self
        gradientColour(button: applyButton)
//        gradientColour(button: applyButton1)
//        gradientColour(button: applyButton2)
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
        brandView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: brandView.frame.size.height)
        priceRangingView.frame = CGRect(x: 0, y: 0 , width: screenWidth, height: priceRangingView.frame.size.height)
        sliderView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: sliderView.frame.size.height)
        // Do any additional setup after loading the view.
        
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.title = "Product List"
        

        tblBrandsView.dataSource = self
        tblBrandsView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        srchBrand.delegate = self
       
        
        //load products
        DispatchQueue.main.async {
            commons.showActivityIndicator()
        }
        if (selCat != nil)
        {
            productService.getProductListFromServer(selCat.categoryId!)
        }
        else
        {
            productService.getProductListFromServer(3) // by default..testing
        }
    }
    override func viewDidLayoutSubviews() {
        gradientColour(button: applyButton)
//        gradientColour(button: applyButton1)
//        gradientColour(button: applyButton2)
        
//        gradientColour(button: clearButton)
//        gradientColour(button: clearButton1)
//        gradientColour(button: clearButton2)
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        brandView.isHidden = true
        sliderView.isHidden = true
        priceRangingView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if touches.first != brandView || touches.first != priceRangingView || touches.first != sliderView  {
            brandView.isHidden = true
            sliderView.isHidden = true
            priceRangingView.isHidden = true
        }
    }
    
    @IBAction func shopByCatagoryButtonAction(_ sender: Any) {
        commons.showActivityIndicator()
        productService.getCategoriesFromServer()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commons.hideActivityIndicator()
        appDelegate?.currentController = self
        var colors = [UIColor]()
        colors.append(UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        let homeImage: UIImage = UIImage(named: "Netstore_Source-09")!
        let frameimg: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let homeButton: UIButton = UIButton(frame: frameimg)
        homeButton.setBackgroundImage(homeImage, for: .normal)
        homeButton.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
        homeButton.showsTouchWhenHighlighted = true
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
        self.navigationItem.rightBarButtonItem = barButton
        //navigationItem.rightBarButtonItem = add
        let backItem = UIBarButtonItem()
        //backItem.title = "Lotions & Oils"
        navigationItem.backBarButtonItem = backItem
        
        
       // let displayWidth: CGFloat = self.view.frame.width
        
//        mytableView = UITableView(frame: CGRect(x: 0, y: 50, width: displayWidth, height: 211))
//        mytableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//        mytableView.dataSource = self
//        mytableView.delegate = self
//        brandView.addSubview(mytableView)
        
        //navigationItem.backBarButtonItem?.title = "Lotions & Oils"
        // navigationItem.leftBarButtonItem = display
        
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
    
   
    
    @objc func playTapped()
    {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == tblBrandsView)
        {
            if (DataManager.brandFilterData == nil)
            {
                return 0
            }
            return (DataManager.brandFilterData?.count)!
        }
        else if (tableView == self.tableView)
        {
            // for Product list
            if (DataManager.productData == nil)
            {
                return 0
            }
            return (DataManager.productData?.count)!
        }
        return 0
        
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var curCell : UITableViewCell!
        
        if (tableView == tblBrandsView)
        {
            let cell:BrandFilterTableViewCell = self.tblBrandsView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! BrandFilterTableViewCell
            brand = DataManager.brandFilterData![indexPath.row] as! BrandFilter
            
            cell.lblBrandName.text = brand.name;
            curCell = cell
        }
        else if (tableView == self.tableView)
        {
            let cell:LotionsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! LotionsTableViewCell
            product = DataManager.productData![indexPath.row] as! Product
            //cell.imageViews.image = itemsImagesArray[indexPath.row]
            if (commons.verifyUrl(urlString: product.imageUrl))
            {
                cell.imageViews.load(url: URL(string: product.imageUrl!)!)
                
            }
            else
            {
                cell.imageViews.image = UIImage(named:"noimage.png")
                
            }
            cell.myLabels.text = product.name;//  animals[indexPath.row]
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "AED \(product.price! )")
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cell.discountLabel.attributedText = attributeString
            cell.lblSplPrice.text = "AED \(product.specialPrice! )"
            curCell = cell
        }
        return curCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                if tableView == tblBrandsView
                {
                    return 40
                }
                else if tableView == self.tableView
                {
                    return 105
                }
        return 0;
        
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == tblBrandsView)
        {
              selBrand = DataManager.brandFilterData![indexPath.row] as! BrandFilter
            
        }
        else if (tableView == self.tableView)
        {
            selPrd = DataManager.productData![indexPath.row] as! Product
            let ItemsDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ItemsDetailsViewController") as? ItemsDetailsViewController
            self.navigationController?.pushViewController(ItemsDetailsViewController!, animated: true)
        }
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func priceButtonClicked(_ sender: Any) {
        brandView.isHidden = true
        sliderView.isHidden = true
        priceRangingView.isHidden = false
        priceButton.titleLabel?.tintColor = UIColor.blue
        brandView.isHidden = true
        priceRangingView.isHidden = true
        sliderView.isHidden = false
        self.scrollView.addSubview(sliderView)
    }
    
    @IBAction func brandAction(_ sender: Any) {
        brandView.isHidden = false
        sliderView.isHidden = true
        priceRangingView.isHidden = true
        brandButton.titleLabel?.tintColor = UIColor.blue
        brandView.isHidden = false
        priceRangingView.isHidden = true
        sliderView.isHidden = true
        self.scrollView.addSubview(brandView)
        tableView.reloadData()
    }
    
    @IBAction func sortButtonAction(_ sender: Any) {
        brandView.isHidden = true
        sliderView.isHidden = false
        priceRangingView.isHidden = true
        sortButton.titleLabel?.tintColor = UIColor.blue
        brandView.isHidden = true
        priceRangingView.isHidden = false
        sliderView.isHidden = true
        self.scrollView.addSubview(priceRangingView)
        
    }
    // Price l to h, hto l
    enum priceSortTypes {
        case LtoH
        case HtoL
        case Best
        case New
    }
    var prType : priceSortTypes!
    
    @IBAction func btnClickPriceNew(_ sender: UIButton) {
        prType =  priceSortTypes.New
        DispatchQueue.main.async {
            self.btnPriceNew.imageView?.image = UIImage(named:"radio-on-button.png")
            self.btnPriceBest.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceHtoL.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceLtoH.imageView?.image = UIImage(named:"empty.png")
        }
    }
    @IBAction func btnClickPriceBest(_ sender: UIButton) {
        prType =  priceSortTypes.Best
        DispatchQueue.main.async {
            self.btnPriceNew.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceBest.imageView?.image = UIImage(named:"radio-on-button.png")
            self.btnPriceHtoL.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceLtoH.imageView?.image = UIImage(named:"empty.png")
        }
    }
    @IBAction func btnClickPriceHtoL(_ sender: UIButton) {
        prType =  priceSortTypes.HtoL
        DispatchQueue.main.async {
            self.btnPriceNew.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceBest.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceHtoL.imageView?.image = UIImage(named:"radio-on-button.png")
            self.btnPriceLtoH.imageView?.image = UIImage(named:"empty.png")
        }
    }
    
    @IBAction func btnClickPriceLToH(_ sender: UIButton) {
        prType =  priceSortTypes.LtoH
        DispatchQueue.main.async {
            self.btnPriceNew.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceBest.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceHtoL.imageView?.image = UIImage(named:"empty.png")
            self.btnPriceLtoH.imageView?.image = UIImage(named:"radio-on-button.png")
        }
    }
    @IBAction func btnClickPriceClear(_ sender: UIButton) {
        priceRangingView.isHidden = true
    }
    
    @IBAction func btnClickPriceApply(_ sender: UIButton) {
        priceRangingView.isHidden = true
        if (DataManager.productData == nil)
        {
            return
        }
        if (DataManager.productData?.count == 0)
        {
            return
        }
        
        if ( prType == priceSortTypes.LtoH)
        {
            let sortRes =  DataManager.productData?.sorted(by: { ($0 as! Product).specialPrice < ($1 as! Product).specialPrice })
            if (sortRes == nil)
            {
                Commons.showAlert("Nil", self)
                return
            }
            DataManager.productData = (sortRes as NSArray?)?.mutableCopy() as? NSMutableArray
        
        }
        else  if ( prType == priceSortTypes.HtoL)
        {
            let sortRes =  DataManager.productData?.sorted(by: { ($0 as! Product).specialPrice > ($1 as! Product).specialPrice })
            if (sortRes == nil)
            {
                Commons.showAlert("Nil", self)
                return
            }
            DataManager.productData = (sortRes as NSArray?)?.mutableCopy() as? NSMutableArray
        }
      
        self.tableView.reloadData()
    }
    //brand search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      //  commons.showActivityIndicator()
        productService.getBrandFilterFromServer(searchText)
        
      
    }
    @IBAction func btnBrandClear(_ sender: Any) {
          brandView.isHidden = true
         DataManager.brandFilterData = nil
    }
    
    @IBAction func btnbrandapply(_ sender: UIButton) {
        brandView.isHidden = true
        DataManager.brandFilterData = nil
        if (selCat != nil)
        {
            if (selBrand != nil)
            {
            productService.getProductListUsingFilterFromServer(selCat.categoryId, nil, selBrand.brandId, nil, nil)
            }
        }
        else
        {
            if (selBrand != nil)
            {
                productService.getProductListUsingFilterFromServer(2, nil, selBrand.brandId, nil, nil) //default testing
            }
        }
    }
    
    //slider  Price Range Filer
    
    
    @IBAction func priceSliderClear(_ sender: UIButton) {
          sliderView.isHidden = true
    }
    @IBAction func priceSliderValueChanged(_ sender: UISlider) {
        //print("sslider \(Int(sender.value))")
           DispatchQueue.main.async {
        self.lblCurVal.text = "\(Int(sender.value))"
        }
    }
    
    @IBAction func btnPriceRangeApplyClick(_ sender: UIButton) {
        
         sliderView.isHidden = true
        let min = 0
        let max = sliderPriceRange.value
        if (selCat != nil)
        {
            productService.getProductListUsingFilterFromServer(selCat.categoryId, nil, nil, min, Int(max))
        }
        else
        {
           productService.getProductListUsingFilterFromServer(3, nil, nil, min, Int(max)) // by default..testing
        }
    }
    
    // category move
    
    @IBAction func showCategoryPage(_ sender: UIButton) {
      
        commons.showActivityIndicator()
        productService.getCategoriesFromServer()
    }
}


extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    
}
extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
}
