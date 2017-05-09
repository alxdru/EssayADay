//
//  SettingsController.swift
//  ead
//
//  Created by Alex on 27/07/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class SettingsController: UIViewController, LoginViewControllerProtocol{
    
    @IBOutlet weak var yourAccount: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var emailAdress: UILabel!

    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var settingsTopBar: UINavigationBar!

    @IBOutlet weak var changePasswordButton: UIButton!
    
    @IBOutlet weak var signOutButton: UIButton!

    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var changeProfilePic: UIButton!
    
    @IBOutlet weak var updateInfo: UIButton!
    
    @IBOutlet var sliderFont: UISlider!
    
    @IBAction func userSignsOut(_ sender: AnyObject) {
        
        GIDSignIn.sharedInstance().signOut()
        
        let loginManager:FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        ApplicationDataManager.sharedInstance.dataModel.resetToNull()
        
        loadProfileResources()
        
    }
    
    @IBAction func userSignsIn(_ sender: AnyObject) {
        
        myLoginViewController = storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        myLoginViewController.modalTransitionStyle = .coverVertical
        present(myLoginViewController, animated: true, completion: nil)
        myLoginViewController.loginViewControllerDelegate = self
        
    }
    
    var myLoginViewController:LoginViewController!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        customizeSettings()
        
        setBackButton()
        
        loadProfileResources()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackButton(){
        
        backButton.action = #selector(self.backFunction)
        backButton.target = self
        
    }
    
    func toggleSignButtons(){
        
        if (ApplicationDataManager.sharedInstance.dataModel.profileEmail != ""){
            
            signInButton.isHidden = true
            signOutButton.isHidden = false
            
        }
        
        else{
            
            signInButton.isHidden = false
            signOutButton.isHidden = true
            
        }
        
        
    }
    
    func loadData(){
        
        if ApplicationDataManager.sharedInstance.dataModel.profileImageURL != "" {
            self.yourAccount.text = "Your account"
            self.name.text = ApplicationDataManager.sharedInstance.dataModel.profileName
            self.emailAdress.text = ApplicationDataManager.sharedInstance.dataModel.profileEmail
            self.profileImage.image = UIImage(data: try! Data(contentsOf: URL(string: ApplicationDataManager.sharedInstance.dataModel.profileImageURL)!))
        }
        else {
            self.yourAccount.text = "Your account"
            self.name.text = ApplicationDataManager.sharedInstance.dataModel.profileName
            self.emailAdress.text = ApplicationDataManager.sharedInstance.dataModel.profileEmail
            self.profileImage.image = UIImage(named: "profileImg")
        }
        
    }
    
    func customizeSettings(){
        changePasswordButton.layer.cornerRadius = 10
        changeProfilePic.layer.cornerRadius = 6
        updateInfo.layer.cornerRadius = 10
        signOutButton.layer.cornerRadius = 10
        signInButton.layer.cornerRadius = 10
       
    }

    func backFunction(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func loadProfileResources(){
        
        toggleSignButtons()
        loadData()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
