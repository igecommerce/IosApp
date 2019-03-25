import UIKit
import QuartzCore

class MyOrdersViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    
    let animals: [String] = ["Johnsons Top to Toe", "Apple Bloosom"]
    var notsidedrawer = Int()
    var itemsImagesArray: [UIImage] = [UIImage(named:"image-58.png")!,UIImage(named:"image-59.png")!]
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "tableViewCell"
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    var controladorDeBusca: UISearchController!
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var checkoutbutton: UIButton!
    @IBOutlet weak var continueShoppingButton: UIButton!
    
    var saleOrder : SaleOrder!
    var saleItem : SaleOrderItems!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       appDelegate?.currentController = self
        // Do any additional setup after loading the view.
//        searchBar()
        
        //load sale orders
        DispatchQueue.main.async {
            commons.showActivityIndicator()
            
            if (appDelegate?.user != nil)
            {
                productService.getSalesOrdersFromServer(appDelegate?.user.customerId)
            }
            else
            {
                productService.getSalesOrdersFromServer(60) //60,24,35)  customer id
            }
        }
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        print("Button tapped")
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
        setUpUserInterface()
    }
    @objc func gohome()
    {
        //self.dismiss(animated: true, completion: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.mainViewSetUp()
    }
    
    func setUpUserInterface()
    {
        self.navigationController?.navigationBar.isHidden = false
        var colors = [UIColor]()
        colors.append(UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        if notsidedrawer == 1 {
        let backImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationItem.title = "My Orders"
        }
        else {
            let homeImages: UIImage = UIImage(named: "backArrow")!
            let frameimgs: CGRect = CGRect(x:0, y:0, width:25, height:23)
            let backArrow: UIButton = UIButton(frame: frameimgs)
            backArrow.setBackgroundImage(homeImages, for: .normal)
            backArrow.addTarget(self, action: #selector(gohome), for: .touchUpInside)
            backArrow.showsTouchWhenHighlighted = true
            let leftbarButton: UIBarButtonItem = UIBarButtonItem(customView: backArrow)
            
            self.navigationItem.leftBarButtonItem = leftbarButton
        }
        
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
    func searchBar()
    {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "Search here"
        searchBar.delegate = self
        
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    @objc func addTapped()
    {
        let MyCartViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController
        self.navigationController?.pushViewController(MyCartViewController!, animated: true)
    }
    
    @objc func playTapped()
    {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (DataManager.saleOrderData == nil)
        {
            return 0
        }
        saleOrder = DataManager.saleOrderData![section] as? SaleOrder
        if (saleOrder.saleOrderItems == nil)
        {
            return 0
        }
        return (saleOrder.saleOrderItems.count)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let vw = UIView()
//        vw.backgroundColor = UIColor.red
//
//        return vw
        return "Sale Order \(section)"
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:OrderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! OrderTableViewCell
        saleOrder = DataManager.saleOrderData![indexPath.section] as? SaleOrder
        saleItem = saleOrder.saleOrderItems[indexPath.row] as? SaleOrderItems
        if (commons.verifyUrl(urlString: saleItem.imageUrl))
        {
            cell.imgPrd.load(url: URL(string: saleItem.imageUrl!)!)
            
        }
        else
        {
            cell.imgPrd.image = UIImage(named:"noimage.png")
            
        }
        
        
        cell.prdName.text = saleItem.productName
        cell.lblPrice.text = "AED \(saleItem.price!)"
        cell.lblTotal.text = "AED \(saleOrder.grandTotal!)"
        cell.btnInvoice.addTarget(self, action: #selector(MyOrdersViewController.btnInvoiceClicked(_:)), for: .touchUpInside)
        return cell
    }
    @IBAction func btnInvoiceClicked(_ sender: UIButton) {
        let cell = sender.superview?.superview as! OrderTableViewCell
        let indexPath = tableView.indexPath(for: cell)
        saleOrder = DataManager.saleOrderData![(indexPath?.section)!] as? SaleOrder
        saleItem = saleOrder.saleOrderItems[(indexPath?.row)!] as? SaleOrderItems
        selSaleOrder = saleOrder    // assign to global var
        let OrderDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as? OrderDetailsViewController
        self.navigationController?.pushViewController(OrderDetailsViewController!, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print("You tapped cell number \(indexPath.row).")
//        orderDetailsViewController = true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (DataManager.saleOrderData == nil)
        {
            return 0
        }
        return (DataManager.saleOrderData?.count)!
    }
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
          saleOrder = DataManager.saleOrderData![section] as? SaleOrder
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" //  HH:mm
        
        let orddate = "\(saleOrder.createdDate[2] as! Int)/\(saleOrder.createdDate[1] as! Int)/\(saleOrder.createdDate[0] as! Int)"
        
        
        let headerView = OrderHeaderView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        headerView.lblOrdId.text = "\(saleOrder.id!)"
        headerView.lblOrdDate.text =  orddate //formatter.string(from: orddate!)
        headerView.lblDeliverDate.text = orddate // formatter.string(from: orddate!)
        
        return headerView
    }
   
    
}


