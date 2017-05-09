//
//  EssayController.swift
//  ead
//
//  Created by Alex on 22/07/16.
//  Copyright © 2016 orgname. All rights reserved.
//


import UIKit
import

class EssayController: UIViewController, UIScrollViewDelegate, ViewControllerProtocol, AlertViewControllerProtocol, MenuViewProtocol _ = {
    
    
    var blurEffect:UIBlurEffect!
    var blurEffectView:UIVisualEffectView!
    
    var myAlert:AlertViewController!
    
    var menuViewController: MenuController!
    
    var welcomeViewController:ViewController!
    
    @IBOutlet weak var webViewObject: UIWebView!
 
    
    func viewDidLoad() {
        
        super.viewDidLoad()
        
        openMenu()
        
        webViewCustomization()
    
        alertActionCustomize()

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.webViewObject.load(ApplicationDataManager.sharedInstance.dataFromServer as Data, mimeType: "text/html", textEncodingName: "",  baseURL: URL())
        
        initWelcomeController()
        
        

    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func initWelcomeController(){
        
        if (welcomeViewController == nil) {
            welcomeViewController = storyboard?.instantiateViewController(withIdentifier: "Welcome") as! ViewController
            welcomeViewController.viewControllerDelegate = self
            self.view.addSubview((welcomeViewController.view))
        }
        else {
            
        }
    
    }
    
    func webViewCustomization(){
        webViewObject.scrollView.bounces = false
        webViewObject.scrollView.delegate = self
        webViewObject.scrollView.showsHorizontalScrollIndicator = false
        webViewObject.scrollView.showsVerticalScrollIndicator = false
    }
    
    
    
    func openMenu(){

        if self.revealViewController() != nil {
            
            revealViewController().delegate = self
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealOverdraw = 0
            
            let screenSize = UIScreen.main.bounds
            self.revealViewController().rearViewRevealWidth = screenSize.width * 0.88
            
            self.revealViewController().panGestureRecognizer().isEnabled = false

        }
    }
    
    func continueButtonPressed() {
        showPopup(false)
    }
    
    func diamondButtonTapped() {
        
        
        if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce"))
        {
            var frame = self.welcomeViewController.view.frame
            frame.origin.y = -self.welcomeViewController.view.frame.size.height
            
            UIView.animate(withDuration: 0.5, animations: {
                self.welcomeViewController.view.frame = frame;
                
            })
            
            self.revealViewController().panGestureRecognizer().isEnabled = true
        }
        else
        {
            
            let myWelcomeTut = storyboard!.instantiateViewController(withIdentifier: "WelcomeTut") as! WelcomeTutViewController
            myWelcomeTut.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(myWelcomeTut, animated: true, completion: nil)
            
        }

        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let scrollViewHeight = scrollView.frame.size.height
        let scrollContentSizeHeight = scrollView.contentSize.height
        let scrollOffset = scrollView.contentOffset.y
        if (scrollOffset == 0){
            
            showPopup(true)
            
        }
        else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight){
        
        }
    }
 

    
    
    func showPopup(_ visible : Bool) {
        
        if visible {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.myAlert.view.alpha = 1
                self.blurEffectView.alpha = 0.7
            })
            
            self.revealViewController().panGestureRecognizer().isEnabled = false
            
        }
            
        else {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.myAlert.view.alpha = 0
                self.blurEffectView.alpha = 0
            })
            
            self.revealViewController().panGestureRecognizer().isEnabled = true
        }
    }
    
    func showOverlay(_ visible: Bool){
        
        if visible {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blurEffectView.alpha = 0.7
            })
        }
            
        else {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blurEffectView.alpha = 0
            })
            
        }

    }
    
    func alertActionCustomize(){
        
       
        myAlert = storyboard!.instantiateViewController(withIdentifier: "alert") as! AlertViewController
        myAlert.alertViewControllerDelegate = self
        myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        
    
        blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        
        self.view.addSubview(blurEffectView)
        self.view.addSubview(myAlert.view)
        
        myAlert.view.alpha = 0
        blurEffectView.alpha = 0
   
    }
    
}


extension EssayController:SWRevealViewControllerDelegate {
 
    func revealController(_ revealController: SWRevealViewController!, animateTo position: FrontViewPosition) {
        
        switch position {
        case .left:
            blurEffectView.alpha = 0.0
        case .right:
            blurEffectView.alpha = 0.7
        default:
            break
        }
        
    }

    func revealController(_ revealController: SWRevealViewController!, panGestureMovedToLocation location: CGFloat, progress: CGFloat, overProgress: CGFloat) {
        
        blurEffectView.alpha = (progress * 7)/10
        
    }


}
    
    


