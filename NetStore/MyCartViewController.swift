

import UIKit

class MyCartViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let animals: [String] = ["Johnsons Top to Toe", "Apple Bloosom", "Gentle Cleansing", "Sebamed Baby"]
    
   var itemsImagesArray: [UIImage] = [UIImage(named:"image-58.png")!,UIImage(named:"image-59.png")!,UIImage(named:"image-60.png")!,UIImage(named:"image-61.png")!]
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "tableViewCell"
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var checkoutbutton: UIButton!
    @IBOutlet weak var continueShoppingButton: UIButton!

    @IBOutlet weak var scrollView: UIScrollView!
    
    var lblPriceCaption : UILabel!
    var btnPriceCaption :UIButton!
    var quoteItem : QuoteOrderItems!
    
    @IBAction func continueShoppingButtonAction(_ sender: Any) {
      let itemListView = self.storyboard?.instantiateViewController(withIdentifier: "Lotions_oilViewController") as? Lotions_oilViewController
      self.navigationController?.pushViewController(itemListView!, animated: true)
    }
    
    @IBAction func checkoutbuttonAction(_ sender: Any) {
//        deliveryViewController = true
//                let OrderDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController
//                self.navigationController?.pushViewController(OrderDetailsViewController!, animated: true)
        placeOrderRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        appDelegate?.currentController = self
        
        gradientColour(button: continueShoppingButton)
        gradientColour(button: checkoutbutton)
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 120))
        scrollView.contentSize = CGSize(width: self.view.frame.size.width , height: self.tableView.frame.size.height + 120)
        customView.backgroundColor = UIColor.white
        
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.title = "My Cart"
      
        let label2 = UILabel(frame: CGRect(x: 0, y: 0, width:screenWidth , height: 20))
        label2.text = ""
        label2.backgroundColor = UIColor.lightGray
        
        let label = UILabel(frame: CGRect(x: 0, y: 30, width: 150, height: 30))
        label.text = "Price Details"
        let labelLine = UILabel(frame: CGRect(x: 0, y: 60, width: self.tableView.frame.size.width, height: 1))
        labelLine.backgroundColor = UIColor.lightGray
        
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 80, width: 150, height: 30))
        label1.text = "Price "
        
        let button = UIButton(frame: CGRect(x: self.view.frame.size.width - 100, y: 80, width: 100, height: 30))
        button.setTitle("AED 10.72", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
       
        lblPriceCaption = label1
        btnPriceCaption = button
        if (DataManager.quoteDetailData != nil)
         {
            
            label1.text = "Price \(DataManager.quoteDetailData?.quoteOrderItems!.count ?? 0) Item(s)"
            button.setTitle("AED \(DataManager.quoteDetailData?.subTotal! ?? 0)", for: .normal)
        }
        else
        {
             button.setTitle("AED 0.00", for: .normal)
        }
        customView.addSubview(button)
        customView.addSubview(label2)
        customView.addSubview(label)
        customView.addSubview(labelLine)
        customView.addSubview(label1)
        tableView.tableFooterView = customView
        // Do any additional setup after loading the view.
      
    }
    
    
    @objc func buttonAction(_ sender: UIButton!) {
        print("Button tapped")
    }
    
    override func viewDidLayoutSubviews() {
        gradientColour(button: continueShoppingButton)
        gradientColour(button: checkoutbutton)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        // let display = UIBarButtonItem(title: "Display", style: .plain, target: self, action: #selector(playTapped))
        commons.hideActivityIndicator()
        appDelegate?.currentController = self
        
        let homeImage: UIImage = UIImage(named: "Netstore_Source-09")!
        let frameimg: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let homeButton: UIButton = UIButton(frame: frameimg)
        homeButton.setBackgroundImage(homeImage, for: .normal)
      //  homeButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        homeButton.showsTouchWhenHighlighted = true
        let barButton: UIBarButtonItem = UIBarButtonItem(customView: homeButton)
        self.navigationItem.rightBarButtonItem = barButton
        //navigationItem.rightBarButtonItem = add
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
    
  
    
    @objc func playTapped()
    {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 1
        if (DataManager.quoteDetailData == nil)
        {
            return 0
        }
        if (DataManager.quoteDetailData?.quoteOrderItems == nil)
        {
            return 0
        }
        return (DataManager.quoteDetailData?.quoteOrderItems.count)!
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        quoteItem = DataManager.quoteDetailData?.quoteOrderItems![indexPath.row] as! QuoteOrderItems
        
        let cell:CartViewCellTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CartViewCellTableViewCell
        
        //cell.imageViews.image = itemsImagesArray[indexPath.section]
        cell.imageViews.load(url: URL(string: quoteItem.imageUrl!)!)
        cell.prdName.text = quoteItem.productName // animals[indexPath.row]
        cell.lblPrice.text = "AED \(quoteItem.price! )"
        cell.lblQty.text = "\(quoteItem.quantity!)"
        cell.lblMinus.addTarget(self, action: Selector(("btnMinus:")), for: .touchUpInside)
        cell.lblPlus.addTarget(self, action: Selector(("btnPlus:")), for: .touchUpInside)
        cell.btnRemove.addTarget(self, action: Selector(("btnRemoveItem:")), for: .touchUpInside)
        return cell
    }
    @IBAction func btnPlus(_ sender: UIButton) {
          let cell = sender.superview?.superview?.superview as! CartViewCellTableViewCell
        var qty : Int? = Int(cell.lblQty.text!)
        qty = qty! + 1
        cell.lblQty.text = "\(qty!)"
    }
    @IBAction func btnMinus(_ sender: UIButton) {
        let cell = sender.superview?.superview?.superview as! CartViewCellTableViewCell
        var qty : Int? = Int(cell.lblQty.text!)
        qty = qty! - 1
        if (qty! <= 0)
        {
            qty = 1
        }
        cell.lblQty.text = "\(qty!)"
    }
    @IBAction func btnRemoveItem(_ sender: UIButton) {
        let cell = sender.superview?.superview as! CartViewCellTableViewCell
        let indexPath = self.tableView.indexPath(for: cell)
        quoteItem = DataManager.quoteDetailData?.quoteOrderItems![(indexPath?.row)!] as! QuoteOrderItems
        
        
        let msgStr = "Are you sure to remove"
        let alertController = UIAlertController(title: DataManager.appName, message: msgStr, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "YES", style: .default) { (action:UIAlertAction) in
            let cartItem = CartItem()
            cartItem.quoteId = self.quoteItem.quoteId
            cartItem.productId = self.quoteItem.productId
            cartItem.quantity = 0
            cartItem.customerId = appDelegate?.user.customerId
            cartItem.websiteId = 1 // to change ?
            productService.addProductToCartAtServer(cartItem, 3, false, false)  //3 for delete
        }
        let action2 = UIAlertAction(title: "NO", style: .default) { (action:UIAlertAction) in
            
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        appDelegate?.currentController.present(alertController, animated: true, completion: nil)
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
    
    func deleteItemCompletion()
    {
        let msgStr = "Item Removed"
        let alertController = UIAlertController(title: DataManager.appName, message: msgStr, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            if (self.lblPriceCaption != nil && self.btnPriceCaption != nil)
            {
                self.lblPriceCaption.text = "Price"
                self.btnPriceCaption.setTitle("AED 0.00" , for: .normal)
            }
            self.tableView.reloadData()
        }
        alertController.addAction(action1)
        appDelegate?.currentController.present(alertController, animated: true, completion: nil)
        
    }
    func placeOrderCompletion()
    {
        let msgStr = "Order Placed. Thank You"
        let alertController = UIAlertController(title: DataManager.appName, message: msgStr, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            productService.resetQuoteToEmpty()
            let myordersView = self.storyboard?.instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
            self.navigationController?.pushViewController(myordersView!, animated: true)
        }
        alertController.addAction(action1)
        appDelegate?.currentController.present(alertController, animated: true, completion: nil)
        
    }
    func placeOrderRequest()
    {
        let msgStr = "Confirm Order..(Yes/No)"
        let alertController = UIAlertController(title: DataManager.appName, message: msgStr, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
           productService.placeSalesOrderToServer(DataManager.quoteDetailData?.id)
        }
        let action2 = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction) in
            }
        alertController.addAction(action1)
        alertController.addAction(action2)
        appDelegate?.currentController.present(alertController, animated: true, completion: nil)
        
    }
}

