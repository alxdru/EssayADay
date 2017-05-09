//
//  RegistrationViewController.swift
//  ead
//
//  Created by Alex on 12/08/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var strDate:String!
    
    @IBAction func datePickerAction(_ sender: AnyObject) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d-MMM-yyyy"
        strDate = dateFormatter.string(from: datePicker.date)
        
    }
    
    
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registrationAct(_ sender: AnyObject) {
        
        if verifyTxtFields() == true{
            ConnectionManager.sharedInstance.registerUser(txtFirstName.text!,lastName: txtLastName.text!,email: txtEmail.text!,password: txtPassword.text!, dateOB: "null")

        }
        else{
            print("Cannot create account because of incomplete data")
        }
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func verifyTxtFields() -> Bool{
        let alert: UIAlertController = UIAlertController(title: "Oops!", message: "Default", preferredStyle: .alert)
        
        if (txtFirstName.text!.utf16.count == 0){
            
            alert.message = "Please enter your first name."
            let action:UIAlertAction = UIAlertAction(title:"OK", style: .default, handler: nil )
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            return false
        
        }else if (txtLastName.text!.utf16.count == 0){
            alert.message = "Please enter your last name."
            let action:UIAlertAction = UIAlertAction(title:"OK", style: .default, handler: nil )
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
            return false
        }else if (txtEmail.text!.utf16.count == 0 ){
            alert.message = "Please enter your email address."
            let action:UIAlertAction = UIAlertAction(title:"OK", style: .default, handler: nil )
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            return false
        }else if isValidEmail(txtEmail.text!) == false{
            alert.message = "Please enter your correct email address."
            let action:UIAlertAction = UIAlertAction(title:"OK", style: .default, handler: nil )
            alert.addAction(action)
                
            present(alert, animated: true, completion: nil)
            
            return false
        }else if txtPassword.text!.utf16.count == 0{
            alert.message = "Please enter your password."
            let action:UIAlertAction = UIAlertAction(title:"OK", style: .default, handler: nil )
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
            return false
//        }else if txtFacebookID.text!.utf16.count == 0{
//            alert.message = "Please enter your first name."
//            let action:UIAlertAction = UIAlertAction(title:"OK", style: .Default, handler: nil )
//            alert.addAction(action)
//            
//            presentViewController(alert, animated: true, completion: nil)
            
        }else{
            
            alert.title = "User Registration!"
            alert.message = "Your Registration is successfully."
            let action:UIAlertAction = UIAlertAction(title:"OK", style: .default, handler: nil )
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
            return true
        }
        
        
    }
    
    func isValidEmail(_ testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    


}
