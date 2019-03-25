//
//  ItemsDetailsViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 07/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class ItemsDetailsViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var addtoCartButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
   //  @IBOutlet weak var mainView: UIView!

    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var imageView2: UIImageView!
    
    
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var imagePrd: UIImageView!
    @IBOutlet var lblPrdname: UILabel!
    
    @IBOutlet weak var lblUsage: UILabel!
    @IBOutlet weak var txtvwDesc: UITextView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblSplPrice: UILabel!
    @IBOutlet var lblUnit: UILabel!
    @IBOutlet weak var addtoCart: UIButton!
    @IBOutlet weak var buyNow: UIButton!

    
    @IBOutlet weak var mainView: UIView!
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate?.currentController=self
gradientColour(button: addtoCart)
        gradientColour(button: buyNow)
        mainView.layer.borderWidth=1.0
        mainView.layer.borderColor = UIColor.black.cgColor
        mainView.layer.masksToBounds = false
        imageView.layer.borderWidth=1.0
        imageView.layer.borderColor = UIColor.green.cgColor
        imageView.layer.masksToBounds = false
         scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 800)
       // mainView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            //CGRect(x:0 , y:0, widht:self.scrollView.frame.size.width, height:self.scrollView.frame.size.height)
      //  self.scrollView.addSubview(self.mainView)
        // Do any additional setup after loading the view.
        
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        
       
        //load product detail
        commons.showActivityIndicator()
        if (selPrd != nil)
        {
            productService.getProductDetailFromServer(selPrd.productId!)
        }
        else
        {
            productService.getProductDetailFromServer(3) // by default..testing
        }
        
    }
    func loadData()
    {
        lblPrdname.text = DataManager.productDetailData?.attribute.name
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "AED \(DataManager.productDetailData?.price.price ?? 0 )")
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        lblPrice.attributedText = attributeString
        lblSplPrice.text = "AED \(DataManager.productDetailData?.price.specialPrice ?? 0)"
        
        if commons.verifyUrl(urlString: DataManager.productDetailData?.image.image)
        {
            imagePrd.load(url: URL(string: (DataManager.productDetailData?.image.image!)!)!)
            
        }
        else
        {
            imagePrd.image = UIImage(named:"noimage.png")
            
        }
        if commons.verifyUrl(urlString: DataManager.productDetailData?.image.thumbnail1 )
        {
            imageView.load(url: URL(string: (DataManager.productDetailData?.image.thumbnail1!)!)!)
            
        }
        else
        {
            imageView.image = UIImage(named:"noimage.png")
            
        }
        
        if commons.verifyUrl(urlString: DataManager.productDetailData?.image.thumbnail2)
        {
            imageView2.load(url: URL(string: (DataManager.productDetailData?.image.thumbnail2!)!)!)
            
        }
        else
        {
            imageView2.image = UIImage(named:"noimage.png")
            
        }
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped1(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer2:)))
        imageView2.isUserInteractionEnabled = true
        imageView2.addGestureRecognizer(tapGestureRecognizer2)
        
        txtvwDesc.text = DataManager.productDetailData?.attribute.desc
        lblUsage.text = DataManager.productDetailData?.attribute.usage
        
    }
    @objc func imageTapped1(tapGestureRecognizer: UITapGestureRecognizer)
    {
        imageView.layer.borderWidth=1.0
        imageView.layer.borderColor = UIColor.green.cgColor
        imageView.layer.masksToBounds = false
        imageView2.layer.borderWidth=0
        imageView2.layer.borderColor = nil
        print("thumbnail 1")
       
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        imagePrd.image = tappedImage.image!
        
        
        // Your action
    }
    @objc func imageTapped2(tapGestureRecognizer2: UITapGestureRecognizer)
    {
        imageView2.layer.borderWidth=1.0
        imageView2.layer.borderColor = UIColor.green.cgColor
        imageView2.layer.masksToBounds = false
        imageView.layer.borderWidth=0
        imageView.layer.borderColor = nil
        print("thumbnail 2")
        
        let tappedImage = tapGestureRecognizer2.view as! UIImageView
        imagePrd.image = tappedImage.image!
        
    }
    
    override func viewDidLayoutSubviews() {
        gradientColour(button: addtoCart)
        gradientColour(button: buyNow)

    }
    
    @IBAction func btnMinusAction(_ sender: Any) {
        var qty : Int? = Int(lblQty.text!)
        qty = qty! - 1
        if (qty! <= 0)
        {
            qty = 1
        }
        lblQty.text = "\(qty!)"
    }
    @IBAction func btnPlusAction(_ sender: Any) {
        var qty : Int? = Int(lblQty.text!)
        qty = qty! + 1
        if (qty! > (DataManager.productDetailData?.inventory.stock!)!)
        {
            qty = DataManager.productDetailData?.inventory.stock!
            Commons.showAlert("Qty exceeds the stock", self)
        }
        lblQty.text = "\(qty!)"
    }
    override func viewWillAppear(_ animated: Bool) {
        commons.hideActivityIndicator()
        appDelegate?.currentController=self
        let homeImage: UIImage = UIImage(named: "Netstore_Source-09")!
        let frameimg: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let homeButton: UIButton = UIButton(frame: frameimg)
        homeButton.setBackgroundImage(homeImage, for: .normal)
        homeButton.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
        homeButton.showsTouchWhenHighlighted = true
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
        self.navigationItem.rightBarButtonItem = barButton
        
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
    @IBAction func addToCartButtonAction(_ sender: Any) {
        print("Default Address id : \(DataManager.addressId)")
        
        if (DataManager.addressId == nil)
        {
            // move to login screen
            let alertController = UIAlertController(title: DataManager.appName, message: "Please set the default Address.", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                DataManager.isFromDetailView = true
                let addrView = appDelegate?.currentController.storyboard?.instantiateViewController(withIdentifier: "AddressViewController") as? AddressViewController
                appDelegate?.currentController.navigationController?.pushViewController(addrView!, animated: true)
            }
            alertController.addAction(action1)
            appDelegate?.currentController.present(alertController, animated: true, completion: nil)
            return;
        }
        let qty : Int? = Int(lblQty.text!)
        
        if (qty == 0)
        {
            Commons.showAlert("Please set Quantity", self)
            return
        }
        let cartItem = CartItem()
        cartItem.productId = selPrd.productId
        cartItem.quantity = qty
        cartItem.customerId = appDelegate?.user.customerId
        cartItem.websiteId = 1 // to change ?
        if (appDelegate?.user.quoteId  == nil )  // no quote exist
        {
            //add as new product
            cartItem.addressId = DataManager.addressId
            productService.addProductToCartAtServer(cartItem, 1, false, false)
            return
        }
        else
        {
            //read quote for product exist
            productService.readCartQuote(selPrd.productId, appDelegate?.user.quoteId)
            return
        }
        
    }
    func productExistCheckCompletion(_ isPrdExist : Bool!)
    {
        let qty : Int? = Int(lblQty.text!)
        let cartItem = CartItem()
        cartItem.quoteId = appDelegate?.user.quoteId
        cartItem.productId = selPrd.productId
        cartItem.quantity = qty
        cartItem.customerId = appDelegate?.user.customerId
        cartItem.websiteId = 1 // to change ?
        
        if (isPrdExist == true)
        {
            let msgStr = "Product Already Exist. Select Update/Replace/Cancel "
            let alertController = UIAlertController(title: DataManager.appName, message: msgStr, preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Update", style: .default) { (action:UIAlertAction) in
                commons.showActivityIndicator()
                productService.addProductToCartAtServer(cartItem,2,false ,true)
                
                   }
            let action2 = UIAlertAction(title: "Replace", style: .default) { (action:UIAlertAction) in
                commons.showActivityIndicator()
                  productService.addProductToCartAtServer(cartItem,2,true ,true)
            }
            let action3 = UIAlertAction(title: "Cancel", style: .default) { (action:UIAlertAction) in
            }
            alertController.addAction(action1)
            alertController.addAction(action2)
            alertController.addAction(action3)
            appDelegate?.currentController.present(alertController, animated: true, completion: nil)
        }
        else
        {
            //add a product
            commons.showActivityIndicator()
            productService.addProductToCartAtServer(cartItem,2,false ,false)
        }
    }
    func addOrUpdateCompletion(_ cartOp : Int!)
    {
        let msgStr = "Cart Updated"
        let alertController = UIAlertController(title: DataManager.appName, message: msgStr, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            let MyCartViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController
            self.navigationController?.pushViewController(MyCartViewController!, animated: true)
        }
        alertController.addAction(action1)
        appDelegate?.currentController.present(alertController, animated: true, completion: nil)
  
    }
    
}
