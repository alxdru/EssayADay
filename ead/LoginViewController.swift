//
//  LoginViewController.swift
//  ead
//
//  Created by Alex on 11/08/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit


protocol LoginViewControllerProtocol{
    
    func loadProfileResources()
    
}

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var buttonGoogle: GIDSignInButton!

    @IBOutlet weak var buttonFacebook: FBSDKLoginButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func xWasPressed(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    var loginViewControllerDelegate:LoginViewControllerProtocol!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureFacebook()
        
        configureGoogle()
        
        customize()
        
        // Do any additional setup after loading the view.
    }

    func customize(){
        
        
        loginButton.layer.cornerRadius = 12.0
        
        
        let borderAlpha : CGFloat = 1.0
        signupButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        signupButton.layer.cornerRadius = 13.0
        signupButton.layer.borderWidth = 1.0
        
    }
    
    //FACEBOOK
    func configureFacebook(){
        
        buttonFacebook.readPermissions = ["public_profile","email","user_friends"]
        buttonFacebook.delegate = self
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
        
        {
            if ((error) != nil) {
                // Process error
            }
                
            else if result.isCancelled {
                print("The user canceled the sign-in flow.")
            }
                
            else {
                FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large), email, age_range"]).startWithCompletionHandler { (connection, result, error) -> Void in
                    
                    let strFirstName: String = (result.objectForKey("first_name") as? String)!
                    let strLastName: String = (result.objectForKey("last_name") as? String)!
                    let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
                    //let nrForAgeRange: Int = (result.objectForKey("age_range") as? Int)!
                    let strForEmail: String = (result.objectForKey("email") as? String)!
                    
                    ApplicationDataManager.sharedInstance.dataModel.profileEmail = strForEmail
                    ApplicationDataManager.sharedInstance.dataModel.profileFirstName = strFirstName
                    ApplicationDataManager.sharedInstance.dataModel.profileLastName = strLastName
                    
                    ApplicationDataManager.sharedInstance.dataModel.profileName = "\(strFirstName) \(strLastName)"
                    ApplicationDataManager.sharedInstance.dataModel.profileImageURL = strPictureURL
                    //ApplicationDataManager.sharedInstance.dataModel.profileAgeRange = nrForAgeRange
                    
                    self.loginViewControllerDelegate.loadProfileResources()
                }
                    let revealController = self.storyboard?.instantiateViewController(withIdentifier: "Revealer" )
                    
                    if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce")){
                        
                        
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    else{
                        self.present(revealController!, animated: false, completion: nil)
                        
                        UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
                        UserDefaults.standard.synchronize()
                    }
                
            }
            
        }

    
    
    func  loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        print("a intrat in logout")
        
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        ApplicationDataManager.sharedInstance.dataModel.resetToNull()
        
    }
    
    //GOOGLE
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func configureGoogle() {
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    func sign(inWillDispatch signIn: GIDSignIn!, error: NSError!) {
      //  myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
                present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
                dismiss viewController: UIViewController!) {
        let revealController = self.storyboard?.instantiateViewController(withIdentifier: "Revealer" )
        self.dismiss(animated: true, completion: nil)
        
        if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce")){
            
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.present(revealController!, animated: false, completion: nil)
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
        }

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                withError error: NSError!)
    {
        
        if (error == nil)
            
        {
            
            // Perform any operations on signed in user here.
            let userId = user.userID // For client-side use only!
            let idToken = user.authentication.idToken //Safe to send to the server
            let name = user.profile.name
            let email = user.profile.email
            let userImageURL = user.profile.imageURL(withDimension: 200)

            // let dateOfBirth = user.prof
            // ...

            ApplicationDataManager.sharedInstance.dataModel.profileImageURL = String (describing: userImageURL)
            ApplicationDataManager.sharedInstance.dataModel.profileEmail = email
            ApplicationDataManager.sharedInstance.dataModel.profileName = name
         
            self.loginViewControllerDelegate.loadProfileResources()
            
            

        }
        else
        {
            print("\(error.localizedDescription)")
        }
        
        
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
                withError error: NSError!)
    {
        
        // Perform any operations when the user disconnects from app here.
        
        ApplicationDataManager.sharedInstance.dataModel.resetToNull()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
