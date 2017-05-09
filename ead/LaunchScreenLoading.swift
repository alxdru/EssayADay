//
//  LaunchScreenLoading.swift
//  ead
//
//  Created by Alex on 01/08/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

class LaunchScreenLoading: UIViewController, ConnectionManagerProtocol {

    @IBOutlet weak var diamondImage: UIImageView!
    @IBOutlet weak var textImage: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConnectionManager.sharedInstance.connectionManagerDelegate = self
        
        diamondImage.alpha = 0
        textImage.alpha = 0
        
        self.view.bringSubview(toFront: diamondImage)
        self.view.bringSubview(toFront: textImage)
        
    
        ConnectionManager.sharedInstance.downloadResources()
        
        self.animation()
        
        
        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didFinishDownloadResources() {
        
        transition()
        
    }
    
    
    func animation(){
        
        UIView.animate(withDuration: 2, delay: 0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat] , animations: {
            self.diamondImage.alpha = 1
            self.textImage.alpha = 1
            }, completion: nil)
        
    }
    
    func transition() {
        
        let delayTime = DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    
            let revealController = self.storyboard?.instantiateViewController(withIdentifier: "Revealer" )
            
            revealController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(revealController!, animated: true, completion: nil)

    
    }
    
    
}
