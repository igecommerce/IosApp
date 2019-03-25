//
//  ViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 02/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var orLabelTwo: UILabel!
    @IBOutlet weak var orLabelOne: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googlebutton: UIButton!
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: screenWidth, height: facebookButton.frame.origin.y + facebookButton.frame.size.height)
        backgroundViewImage(view: self.mainView)
        shadowView(viewShadow: emailView)
        shadowView(viewShadow: passwordView)
        gradientColour(button: submitButton)
        emailTextField.placeholder = "Enter your email"
//        emailTextField.text = "test2@gmail.com"
   //  passwordTextField.text="123456"
        passwordTextField.placeholder = "Password"
        googleandfacebookconfigure(button: self.googlebutton)
        googleandfacebookconfigure(button: self.facebookButton)
        orLabelOne.frame = CGRect(x:orLabelOne.frame.origin.x, y:orLabelOne.frame.origin.y, width:orLabelOne.frame.width, height:0.5)
        orLabelTwo.frame = CGRect(x:orLabelTwo.frame.origin.x, y:orLabelTwo.frame.origin.y, width:orLabelTwo.frame.width, height:0.5)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let tempUser = userService.getUserData()
        if (tempUser != nil)
        {
            emailTextField.text = tempUser?.email
        
        }
        if (dummyEmail != nil)
        {
            emailTextField.text = dummyEmail!
        }
        
        
    }
    override func viewDidLayoutSubviews() {
        gradientColour(button: submitButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var signinpageButtonActions: UIButton!
    
    @IBAction func submitButtonAction(_ sender: Any) {
        if ( passwordTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true )
        {
            Commons.showAlert("Please Fill all fields", self)
            return;
        }
        if (Commons.isValidEmail(inpEmail: (emailTextField?.text)!) != true)
        {
            Commons.showAlert("Invalid Email ID", self)
            return;
        }
       
        if ((passwordTextField.text?.count)! < 6 )
        {
            Commons.showAlert("Password atleast contains 6 characters", self)
            return;
        }
        
        
        
        commons.showActivityIndicator()
        user = userService.checkLogin(emailTextField.text! ,passwordTextField.text! )
        //appDelegate?.settingRootView(.MainViewMode)
    }
    // MARK:- TextField delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        
        return true
    }
    
}

extension UIViewController
{
    func shadowView(viewShadow:UIView)
    {
        viewShadow.backgroundColor = UIColor.white
        viewShadow.layer.shadowColor = UIColor.lightGray.cgColor
        viewShadow.layer.cornerRadius = 20
        viewShadow.layer.shadowOpacity = 0.5
        viewShadow.layer.shadowOffset = CGSize.zero
        viewShadow.layer.shadowRadius = 4
    }
    func backgroundViewImage(view:UIView)
    {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Netstore_Source-01.png")
        backgroundImage.alpha = 0.30
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
    func gradientColour(button:UIButton)
    {
        let colorTop =  UIColor(red: 91.0/255.0, green: 207.0/255.0, blue: 136.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 15.0/255.0, green: 199.0/255.0, blue: 197.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = button.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
    }
    func googleandfacebookconfigure(button:UIButton)
    {
        //        var insetAmount = CGFloat()
        //        insetAmount = 50.0 / 2.0;
        //        button.imageEdgeInsets = UIEdgeInsetsMake(1, -insetAmount + 3, 1, insetAmount)
        //        button.titleEdgeInsets = UIEdgeInsetsMake(0, insetAmount - 70 , 0, -insetAmount)
        //        button.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
    }
}
