//
//  ViewController.swift
//  ead
//
//  Created by Alex on 21/07/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit
import QuartzCore



protocol ViewControllerProtocol {
    func diamondButtonTapped()
}

class ViewController: UIViewController, ConnectionManagerProtocol {
    
    var viewControllerDelegate: ViewControllerProtocol!
    @IBOutlet weak var dayMessage: UILabel!
    
    @IBAction func mainButtonTapped(_ sender: AnyObject) {
        viewControllerDelegate.diamondButtonTapped()
    }
    
    @IBOutlet weak var mainButtonStack: UIStackView!
    @IBOutlet weak var mainButton: UIButton!
    
    @IBOutlet weak var messageNotPressed: UIImageView!
    

    @IBOutlet var welcomeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configWelcome()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        popUpForMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func popUpForMessage (){
        
        messageNotPressed.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        messageNotPressed.alpha = 0.0
        if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce"))
        {
            let delayTime = DispatchTime.now() + Double(Int64(5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delayTime) {
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.messageNotPressed.alpha = 1.0
                    self.messageNotPressed.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    
                }) 
                
            }
        }
        else
        {
            // This is the first launch ever
                UIView.animate(withDuration: 0.25, animations: {
                    self.messageNotPressed.alpha = 1.0
                    self.messageNotPressed.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    
                }) 
            
        }

        
    }
    
    
    func configWelcome(){
        let date = DateFormatter()
        date.setLocalizedDateFormatFromTemplate("EEEE") //formatare data ca ziua
        let stringDate = date.string(from: Date())
        dayMessage.text = stringDate + "'s essay"
        
        if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce"))
        {
            messageNotPressed.image = UIImage(named: "introScreenPopup")
           
        }
        else
        {
            
            // This is the first launch ever
             messageNotPressed.image = UIImage(named: "hiMessage")
            
        }
        
        let downloadedImage = UIImage(data: ApplicationDataManager.sharedInstance.dataImageFromServer as Data)
        welcomeImage.image = downloadedImage
        
        //button effect
        mainButton.startGlowing()
        
        
    }
    

        
    func didFinishDownloadResources() {
        //
    }
        
    
  

}

