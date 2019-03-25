//
//  OrderDetailsViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 09/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit
var deliveryViewController =  Bool()
var orderDetailsViewController = Bool()
class OrderDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    
    let animals: [String] = ["Johnsons Top to Toe", "Apple Bloosom"]
    
    //address
    
    @IBOutlet weak var lblAddrName: UILabel!
    
    @IBOutlet weak var lblCtry_reg_pcode: UILabel!
    @IBOutlet weak var lblAddrStreet: UILabel!
   
    
    //Price Details
    
    
    @IBOutlet weak var lblPriceGrandTotal: UILabel!
    @IBOutlet weak var lblPriceTotal: UILabel!
    @IBOutlet weak var lblPriceDiscount: UILabel!
    @IBOutlet weak var lblPriceShip: UILabel!
    @IBOutlet weak var lblPriceSubtotal: UILabel!
    
    @IBOutlet weak var lblPriceTax: UILabel!
    // order header
    
    @IBOutlet weak var lblOrdDelivered: UILabel!
    @IBOutlet weak var lblOrdDate: UILabel!
    
    @IBOutlet weak var lblOrdId: UILabel!
    //
    
    @IBOutlet weak var afterPromoLineLabel: UILabel!
    @IBOutlet weak var priceDetailsLineLabel: UILabel!
    @IBOutlet weak var deliverLabel: UILabel!
    @IBOutlet weak var continueButtonView: UIView!
    @IBOutlet var addressView: UIView!
    @IBOutlet var afterpromoAppliedViwe: UIView!
    var itemsImagesArray: [UIImage] = [UIImage(named:"image-58.png")!,UIImage(named:"image-59.png")!]
    // cell reuse id (cells that scroll out of view can be reused)
    @IBOutlet weak var continueButton: UIButton!
    let cellReuseIdentifier = "tableViewCell"
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var itmestableView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var havePromoView: UIView!
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet var emailInvoiceView: UIView!
    @IBOutlet var priceDetailsView: UIView!
    @IBOutlet var orderItemsView: UIView!
    @IBOutlet var deliveryAddressView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveandDeilverButton: UIButton!
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    var saleItem : SaleOrderItems!
    
    let empty = ""
    let strZero = "0.00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate?.currentController = self
        
        setUpUserInterface()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func setUpUserInterface()
    {
        let yourBackImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        gradientColour(button: continueButton)
        gradientColour(button: cancelButton)
        gradientColour(button: saveandDeilverButton)
        scrollView.delegate = self
        
        deliverLabel.layer.masksToBounds = true
        deliverLabel.layer.cornerRadius = 5
        
//        if (deliveryViewController == true)
//        {
//            self.navigationItem.title = "Delivery"
//            self.view.addSubview(continueButtonView)
//            beforepromoapplied()
//        }
//        else if (orderDetailsViewController == true)
//        {
//            self.navigationItem.title = "Order Details"
//            continueButtonView.removeFromSuperview()
//            orderDetailsView()
//        }
        
        self.navigationItem.title = "Order Details"
        continueButtonView.removeFromSuperview()
        orderDetailsView()
    }
    
    override func viewDidLayoutSubviews() {
        gradientColour(button: continueButton)
        gradientColour(button: cancelButton)
        gradientColour(button: saveandDeilverButton)
    }
    
    func orderDetailsView()
    {
        orderItemsView.frame = CGRect(x: 0, y: 10, width: screenWidth, height: 50)
        scrollView.addSubview(orderItemsView)
        
        addressView.frame = CGRect(x: 0, y: orderItemsView.frame.size.height + orderItemsView.frame.origin.y + 10, width: screenWidth, height: 100)
        scrollView.addSubview(addressView)
        
        afterpromoAppliedViwe.frame = CGRect(x: 0, y: addressView.frame.size.height + addressView.frame.origin.y + 10, width: screenWidth, height: 240)
        scrollView.addSubview(afterpromoAppliedViwe)
        
        emailInvoiceView.frame = CGRect(x: 0, y: afterpromoAppliedViwe.frame.size.height + afterpromoAppliedViwe.frame.origin.y + 20, width: screenWidth, height: 50)
        scrollView.addSubview(emailInvoiceView)
        
//        itmestableView.frame = CGRect(x: 0, y: emailInvoiceView.frame.size.height + emailInvoiceView.frame.origin.y + 10, width: screenWidth, height: itmestableView.frame.size.height + itmestableView.frame.origin.y + 20 )
        var scrView : UIScrollView!
        scrView = UIScrollView()
       scrView.frame = CGRect(x: 0, y: emailInvoiceView.frame.size.height + emailInvoiceView.frame.origin.y + 10, width: screenWidth, height: itmestableView.frame.size.height + itmestableView.frame.origin.y + 20 )
       itmestableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: itmestableView.frame.size.height)
        scrView.addSubview(itmestableView)
        scrollView.addSubview(scrView!)
        
        tableView.reloadData()
        scrollView.contentSize = CGSize(width: screenWidth, height: itmestableView.frame.size.height + itmestableView.frame.origin.y + 10)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func beforepromoapplied()
    {
    deliveryAddressView.frame = CGRect(x: 0, y: 10, width: screenWidth, height: 150)
    scrollView.addSubview(deliveryAddressView)
    
    priceDetailsView.frame = CGRect(x: 0, y: deliveryAddressView.frame.size.height + deliveryAddressView.frame.origin.y + 10, width: screenWidth, height: 190)
    scrollView.addSubview(priceDetailsView)
    
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.black.cgColor
        yourViewBorder.lineDashPattern = [2, 2]
        yourViewBorder.frame = promoCodeTextField.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: promoCodeTextField.bounds).cgPath
        promoCodeTextField.layer.addSublayer(yourViewBorder)
        
//    promoCodeTextField.layer.borderColor = UIColor.black.cgColor
    havePromoView.frame = CGRect(x: 0, y: priceDetailsView.frame.size.height + priceDetailsView.frame.origin.y + 10, width: screenWidth, height: 50)
    scrollView.addSubview(havePromoView)
    
    itmestableView.frame = CGRect(x: 0, y: havePromoView.frame.size.height + havePromoView.frame.origin.y + 10, width: screenWidth, height: itmestableView.frame.size.height + itmestableView.frame.origin.y + 20 )
    scrollView.addSubview(itmestableView)
    tableView.reloadData()
    scrollView.contentSize = CGSize(width: screenWidth, height: itmestableView.frame.size.height + itmestableView.frame.origin.y )
        loadData()
    }
    func loadData()
    {
        if (selSaleOrder == nil)
        {
            return
        }
        //
        //address
        if (selSaleOrder.saleAddress != nil)
        {
        let saleAddr = selSaleOrder.saleAddress
            self.lblAddrName.text = "\(saleAddr?.firstName ?? empty) \(saleAddr?.lastName ?? empty)"
        self.lblAddrStreet.text = "\(saleAddr?.street ?? empty)"
        self.lblCtry_reg_pcode.text = "\(saleAddr?.country ?? empty) \(saleAddr?.area ?? empty) , \(saleAddr?.postCode ?? empty)"
            
        }
        //Price Details
        var tempStr : String!
        tempStr = selSaleOrder?.grandTotal != nil ? selSaleOrder?.grandTotal!.description : strZero
        self.lblPriceGrandTotal.text = "AED \(tempStr!)"
        self.lblPriceTotal.text = "AED \(tempStr!)"
        tempStr = selSaleOrder?.codCharges != nil ? selSaleOrder?.codCharges!.description : strZero
        self.lblPriceDiscount.text = "AED \(tempStr!)"
        tempStr = selSaleOrder?.shippingAmount != nil ? selSaleOrder?.shippingAmount!.description : strZero
        self.lblPriceShip.text = "AED \(tempStr!)"
        tempStr = selSaleOrder?.subTotal != nil ? selSaleOrder?.grandTotal!.description : strZero
        self.lblPriceSubtotal.text = "AED \(tempStr!)"
        tempStr = selSaleOrder?.taxAmount != nil ? selSaleOrder?.taxAmount!.description : strZero
        self.lblPriceTax.text = "AED \(tempStr!)"
        // order header
        let orddate = "\(selSaleOrder.createdDate[2] as! Int)/\(selSaleOrder.createdDate[1] as! Int)/\(selSaleOrder.createdDate[0] as! Int)"
        
        self.lblOrdDelivered.text = orddate
        self.lblOrdDate.text = orddate
        self.lblOrdId.text = "\(selSaleOrder.id!)"
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        deliveryViewController = false
        orderDetailsViewController = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        // let display = UIBarButtonItem(title: "Display", style: .plain, target: self, action: #selector(playTapped))
        commons.hideActivityIndicator()
        appDelegate?.currentController = self
        
        if (deliveryViewController == true)
        {
            
        }
        else if (orderDetailsViewController == true)
        {
            let homeImage: UIImage = UIImage(named: "Netstore_Source-09")!
            let frameimg: CGRect = CGRect(x:0, y:0, width:25, height:23)
            let homeButton: UIButton = UIButton(frame: frameimg)
            homeButton.setBackgroundImage(homeImage, for: .normal)
            homeButton.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
            homeButton.showsTouchWhenHighlighted = true
            let barButton: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
            
            let searchImage: UIImage = UIImage(named: "search_white")!
            let frameSearchImage: CGRect = CGRect(x:0, y:0, width:10, height:20)
            let searchButton: UIButton = UIButton(frame: frameSearchImage)
            searchButton.setBackgroundImage(searchImage, for: .normal)
            searchButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
            searchButton.showsTouchWhenHighlighted = true
            let searchBarButton: UIBarButtonItem = UIBarButtonItem(customView: searchButton)
            
            navigationItem.rightBarButtonItems = [barButton,searchBarButton]
        }
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
    @objc func addTapped()
    {
        let MyCartViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController
        self.navigationController?.pushViewController(MyCartViewController!, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (selSaleOrder == nil)
        {
            return 0
        }
        if (selSaleOrder.saleOrderItems == nil)
        {
            return 0
        }
        return (selSaleOrder.saleOrderItems.count)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:OrderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! OrderTableViewCell
        
        saleItem = selSaleOrder.saleOrderItems[indexPath.row] as? SaleOrderItems
        if (commons.verifyUrl(urlString: saleItem.imageUrl))
        {
            cell.imgPrd1.load(url: URL(string: saleItem.imageUrl!)!)
            
        }
        else
        {
            cell.imgPrd1.image = UIImage(named:"noimage.png")
            
        }
        
        
        cell.lblPrdName1.text = saleItem.productName
        cell.lblPrice1.text = "AED \(saleItem.price!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        //        let ItemsDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ItemsDetailsViewController") as? ItemsDetailsViewController
        //        self.navigationController?.pushViewController(ItemsDetailsViewController!, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
     //   return self.animals.count
        return 1
    }
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
//        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }

    @IBAction func applyButtonClicked(_ sender: Any) {
//        let subViews = self.scrollView.subviews
//        for subview in subViews{
//            subview.removeFromSuperview()
//        }
//        afterpromoapplied()
    }
    @IBAction func continueButtonClicked(_ sender: Any) {
        let MyOrdersViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
        MyOrdersViewController?.notsidedrawer = 1
        self.navigationController?.pushViewController(MyOrdersViewController!, animated: true)
    }
    
    func afterpromoapplied()
    {
        deliveryAddressView.frame = CGRect(x: 0, y: 10, width: screenWidth, height: 140)
        scrollView.addSubview(deliveryAddressView)
        
        afterpromoAppliedViwe.frame = CGRect(x: 0, y: deliveryAddressView.frame.size.height + deliveryAddressView.frame.origin.y + 10, width: screenWidth, height: 230)
        scrollView.addSubview(afterpromoAppliedViwe)
        
//        havePromoView.frame = CGRect(x: 0, y: priceDetailsView.frame.size.height + priceDetailsView.frame.origin.y + 20, width: screenWidth, height: 50)
//        scrollView.addSubview(havePromoView)
        
        itmestableView.frame = CGRect(x: 0, y: afterpromoAppliedViwe.frame.size.height + afterpromoAppliedViwe.frame.origin.y + 10, width: screenWidth, height: itmestableView.frame.size.height + itmestableView.frame.origin.y + 20 )
        scrollView.addSubview(itmestableView)
        tableView.reloadData()
        scrollView.contentSize = CGSize(width: screenWidth, height: 700)
    }
}
