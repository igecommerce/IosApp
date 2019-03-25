//
//  AddressViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 09/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var pickerButton: UIButton!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var regionPicker: UIPickerView!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var viewPickerBackground: UIView!
    @IBOutlet weak var saveandDeliverButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var savedAddressView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var newAddressView: UIView!
    
    @IBOutlet weak var btnAddress: UIButton!
    
    var isAddButtonChecked : Bool! = false
    
     let empty = ""
    
    @IBOutlet weak var tblAddressView: UITableView!
    var address : Address!
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "addressViewCell"
     var cell = UITableViewCell()
    
    
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    var regionArray: [String] = ["region1", "region2", "region3"]
    var countryArray: [String] = ["Dubai", "Abudabhi", "Katar"]
    
    var activeTextField: UITextField?
       var custId : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate?.currentController = self
        gradientColour(button: cancelButton)
        gradientColour(button: saveandDeliverButton)
        
        
     //   newAddressView.frame = CGRect(x: 0, y: savedAddressView.frame.size.height + savedAddressView.frame.origin.y + 20, width:screenWidth , height: newAddressView.frame.size.height+10)
   //     mainScrollView.addSubview(newAddressView)
        
        mainScrollView.contentSize = CGSize(width: screenWidth, height: newAddressView.frame.origin.y + newAddressView.frame.size.height)


        initializeTextFieldInputView()
        // Do any additional setup after loading the view.
        tblAddressView.delegate=self
        tblAddressView.dataSource=self
        
        let yourBackImage = UIImage(named: "backArrow")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationItem.title = "Select Address"
        
        txtFirstname.delegate = self
        txtLastName.delegate = self
        txtStreet.delegate = self
        txtCity.delegate = self
        regionTextField.delegate = self
        countryTextField.delegate = self
        
//        txtFirstname.text = "ML"
//        txtLastName.text = "ML1"
//        txtStreet.text = "test street"
//        txtCity.text = "test city"
        
        //call  address list
        commons.showActivityIndicator()
     
        if let user = appDelegate?.user
        {
            custId = user.customerId!
        }
//        else
//        {
//            custId = 51  //default
//        }
        
        userService.getAddressesFromServer(custId)
    }
    
    override func viewDidLayoutSubviews() {
        gradientColour(button: cancelButton)
        gradientColour(button: saveandDeliverButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func gohome()
    {
        //self.dismiss(animated: true, completion: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.mainViewSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        // let display = UIBarButtonItem(title: "Display", style: .plain, target: self, action: #selector(playTapped))
        appDelegate?.currentController = self
        commons.hideActivityIndicator()
        
        regionPicker.reloadAllComponents()
        regionPicker.selectRow(0, inComponent: 0, animated: false)
        
        countryPicker.reloadAllComponents()
        countryPicker.selectRow(0, inComponent: 0, animated: false)
        
        let homeImages: UIImage = UIImage(named: "backArrow")!
        let frameimgs: CGRect = CGRect(x:0, y:0, width:25, height:23)
        let backArrow: UIButton = UIButton(frame: frameimgs)
        backArrow.setBackgroundImage(homeImages, for: .normal)
        backArrow.addTarget(self, action: #selector(gohome), for: .touchUpInside)
        backArrow.showsTouchWhenHighlighted = true
        let leftbarButton: UIBarButtonItem = UIBarButtonItem(customView: backArrow)
        self.navigationItem.leftBarButtonItem = leftbarButton
        
        self.navigationController?.navigationBar.isHidden = false
        var colors = [UIColor]()
        colors.append(UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0))
        colors.append(UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0))
        navigationController?.navigationBar.setGradientBackground(colors: colors)

    }
  
    func initializeTextFieldInputView() {
        countryTextField.inputView = viewPickerBackground
        regionTextField.inputView = viewPickerBackground
    }
    
    // MARK:- TextField delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            let next: UIView? = textField.superview?.viewWithTag(textField.tag + 1)
            next?.becomeFirstResponder()
        } else if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        autoreleasepool {
            activeTextField = nil
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        if textField == regionTextField {
            regionPicker.isHidden = false
            countryPicker.isHidden = true
            pickerButton.setTitle("Next", for: .normal)
        } else if textField == countryTextField {
            regionPicker.isHidden = true
            countryPicker.isHidden = false
            pickerButton.setTitle("Done", for: .normal)
        }
        return true
    }
    
    // MARK: - PickerView Delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == regionPicker {
            regionTextField.text = regionArray[row]
        } else if pickerView == countryPicker {
            countryTextField.text = countryArray[row]
        }
    }
    
    // MARK: - PickerView Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == regionPicker {
            return regionArray.count
        } else if pickerView == countryPicker {
            return countryArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == regionPicker {
            return regionArray[row]
        } else if pickerView == countryPicker {
            return countryArray[row]
        }
        
        return nil
    }

    
    @IBAction func saveandDelieverButtonAction(_ sender: Any) {
      
//        var custId : String!
//        if let user = appDelegate?.user
//        {
//            custId = user.customerId!
//        }
//        else
//        {
//            custId="51"  //default
//        }
//
      
        if (isAddButtonChecked == true)
        {
            //validate the form
            if (txtLastName.text?.isEmpty == true || txtFirstname.text?.isEmpty == true || txtStreet.text?.isEmpty == true || regionTextField.text?.isEmpty == true || countryTextField.text?.isEmpty == true)
            {
                Commons.showAlert("Address Fields are Empty", self)
                return;
            }
          commons.showActivityIndicator()
        
          userService.addAddressToServer(custId, txtFirstname.text!, txtLastName.text!, txtStreet.text!, 1, 1, 1, _postCode: 1)
        }
        else
        {
            // move to screen ? cart
            if ( self.address.isDefault == true)
            {
                Commons.showAlert("Set as default address", self)
            }
            else
            {
                 Commons.showAlert("Please select address", self)
            }
        }
        
    }
    
    @IBAction func pickerDoneButtonClicked(_ sender: Any) {
        if activeTextField == regionTextField {
            if regionArray.count > 0 {
                if (regionTextField.text == "") {
                    regionTextField.text = regionArray[0]
                }
            }
            
            regionTextField.resignFirstResponder()
            countryTextField.becomeFirstResponder()
        } else if activeTextField == countryTextField {
            if countryArray.count > 0 {
                if (countryTextField.text == "") {
                    countryTextField.text = countryArray[0]
                }
            }
            
            view.endEditing(true)
        }
    }
    
    
    //tbl view data for addresslist
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if tableView == mytableView
        //        {
        //            return myArray.count
        //        }
        //        return self.animals.count
        if (DataManager.addressData == nil)
        {
            return 0
        }
        return (DataManager.addressData?.count)!
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          var img : UIImage!
       let cell:AddressTableViewCell = self.tblAddressView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! AddressTableViewCell
        address = DataManager.addressData![indexPath.row] as! Address
        let empty = ""
        cell.tvwfname.text = address.firstname ?? empty
        cell.tvwlname.text = address.lastname ?? empty
        cell.tvwStreet.text = address.streetname ?? empty
        cell.tvwRegion.text = address.areaname ?? empty + "," + address.region ?? empty //"\(String(address.regionId))"
        cell.tvwCntry.text = address.country ?? empty //"\(String(address.countryId))"
        cell.tvwPost.text = address.streetname ?? empty //"\(String(address.postcode))"
        
        cell.btnSel.addTarget(self, action: Selector(("btnSelClicked:")), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: Selector(("btnEditClicked:")), for: .touchUpInside)
        cell.isChecked = false
        if ( address.isDefault == true)
        {
            img = UIImage(named:"radio-on-button.png")
        }
        else
        {
            img = UIImage(named:"empty.png")
        }
      
        cell.btnSel.imageView?.image = img!
        return cell
    }
    @IBAction func btnSelClicked(_ sender: UIButton) {
        var img : UIImage!
        let cell = sender.superview?.superview as! AddressTableViewCell
        let indexPath = tblAddressView.indexPath(for: cell)
        address = DataManager.addressData![(indexPath?.row)!] as! Address
         address.isDefault = !( address.isDefault )
        print("is def :" ,address.isDefault)
        if ( address.isDefault == true)
        {
            img = UIImage(named:"radio-on-button.png")
            DataManager.addressId = address.addressId     //default address
            Commons.saveStringProperty(String(DataManager.addressId!), DataManager.strAddrId)
            
        }
        else
        {
            img = UIImage(named:"empty.png")
        }
        DispatchQueue.main.async {
            cell.btnSel.imageView?.image = img!
            
            DataManager.addressData![(indexPath?.row)!] = self.address!
            if ( self.address.isDefault == true)
            {
                self.btnAddress.imageView?.image = UIImage(named:"empty.png")
            }
            
            //Commons.showAlert("Sel", self)
        }
    }
    @IBAction func btnEditClicked(_ sender: UIButton) {
        let cell = sender.superview?.superview as! AddressTableViewCell
        let indexPath = tblAddressView.indexPath(for: cell)
        
        address = DataManager.addressData![(indexPath?.row)!] as! Address
        txtFirstname.text = address.firstname ?? empty
        txtLastName.text = address.lastname ?? empty
        txtStreet.text = address.streetname ?? empty
        regionTextField.text = "\(String(address.regionId))"
        countryTextField.text = "\(String(address.countryId))"
        Commons.showAlert("Edit", self)
    }
    
    
    @IBAction func btnAddAddress(_ sender: UIButton) {
        var img : UIImage!
        txtFirstname.text = empty
        txtLastName.text = empty
        txtStreet.text =  empty
        txtCity.text = empty
        
        self.isAddButtonChecked = !( self.isAddButtonChecked )
      
        if ( isAddButtonChecked == true)
        {
            img = UIImage(named:"radio-on-button.png")
            
        }
        else
        {
            img = UIImage(named:"empty.png")
        }
        DispatchQueue.main.async {
            self.btnAddress.imageView?.image = img
          
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        selAddr = DataManager.addressData![indexPath.row] as! Address
        print ("selected  ...")
//        let ItemsDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "ItemsDetailsViewController") as? ItemsDetailsViewController
//        self.navigationController?.pushViewController(ItemsDetailsViewController!, animated: true)
    }
    

}
