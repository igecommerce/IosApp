//
//  SignUpViewController.swift
//  NetStore
//
//  Created by Murugan Lakshmanan on 02/09/18.
//  Copyright © 2018 Murugan Lakshmanan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UIScrollViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var orLabelTwo: UILabel!
    @IBOutlet weak var orLabelOne: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var reenterpasswordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reenterTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googlebutton: UIButton!
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate?.currentController=self
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
        scrollView.contentSize = CGSize(width: screenWidth, height: facebookButton.frame.origin.y + facebookButton.frame.size.height + 500)
        backgroundViewImage(view: self.mainView)
        shadowView(viewShadow: emailView)
        shadowView(viewShadow: passwordView)
        shadowView(viewShadow: nameView)
        shadowView(viewShadow: reenterpasswordView)
        gradientColour(button: self.submitButton)
        nameTextField.placeholder = "Your Name"
        reenterTextField.placeholder = "Password"
        emailTextField.placeholder = "Email"
        passwordTextField.placeholder = "Re-enter Password"
//        nameTextField.text = "Manoharan"
//        emailTextField.text = "mano@gmail.com"
//        passwordTextField.text="123456"
//        reenterTextField.text="123456"
        emailTextField.delegate = self
        passwordTextField.delegate = self
        reenterTextField.delegate = self
        
        googleandfacebookconfigure(button: self.googlebutton)
        googleandfacebookconfigure(button: self.facebookButton)
        orLabelOne.frame = CGRect(x:orLabelOne.frame.origin.x, y:orLabelOne.frame.origin.y, width:orLabelOne.frame.width, height:0.5)
        orLabelTwo.frame = CGRect(x:orLabelTwo.frame.origin.x, y:orLabelTwo.frame.origin.y, width:orLabelTwo.frame.width, height:0.5)

    }

    override func viewDidLayoutSubviews() {
        gradientColour(button: self.submitButton)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func submitSignUp(_ sender: UIButton) {
        let user = User()
        if (nameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || emailTextField.text?.isEmpty == true )
        {
            Commons.showAlert("Please Fill all fields", self)
            return;
        }
        if (Commons.isValidEmail(inpEmail: (emailTextField?.text)!) != true)
        {
            Commons.showAlert("Invalid Email ID", self)
            return;
        }
        if ( passwordTextField.text != reenterTextField.text)
        {
            Commons.showAlert("Password Mismatch", self)
            return;
        }
        if ((passwordTextField.text?.count)! < 6 )
        {
            Commons.showAlert("Password atleast contains 6 characters", self)
            return;
        }
      
        commons.showActivityIndicator()
        user.firstName = nameTextField.text!
        user.password = passwordTextField.text!
        user.email = emailTextField.text!
        
        userService.signUp(user)
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
     
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.navigationController?.pushViewController(ViewController!, animated: true)

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
