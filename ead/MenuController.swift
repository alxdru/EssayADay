//
//  MenuController.swift
//  ead
//
//  Created by Alex on 22/07/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

// fac blurul ala cu un protocol

protocol MenuViewProtocol{
    
    func showOverlay(_ visible: Bool)
    
}

class MenuController: UIViewController{
  
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var readEssays: UIButton!
    @IBOutlet weak var missedEssays: UIButton!
    @IBOutlet weak var personPhoto: UIImageView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var hiMessage: UILabel!
    
    var menuViewControllerDelegate:MenuViewProtocol!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundMargins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadProfileResources()
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadProfileResources(){
        if ApplicationDataManager.sharedInstance.dataModel.profileImageURL != "" && ApplicationDataManager.sharedInstance.dataModel.profileEmail != "" {
            self.personPhoto.image = UIImage(data: try! Data(contentsOf: URL(string: ApplicationDataManager.sharedInstance.dataModel.profileImageURL)!))
            if ApplicationDataManager.sharedInstance.dataModel.profileFirstName == "" {
                
                self.hiMessage.text = "Hi \(ApplicationDataManager.sharedInstance.dataModel.profileName)!\nYou have:"
                
            }
            
            else {
                
                self.hiMessage.text = "Hi \(ApplicationDataManager.sharedInstance.dataModel.profileFirstName)!\nYou have:"
                
            }
            
        }
        else {
            self.personPhoto.image = UIImage(named: "profileImg")
            self.hiMessage.text = "Hi Stranger!\nYou have:"
        }
        
    }
    
    func roundMargins(){
        saveButton.layer.cornerRadius = 10;
        readEssays.layer.cornerRadius = 10;
        missedEssays.layer.cornerRadius = 10;
        personPhoto.layer.cornerRadius = personPhoto.frame.width/2
        settingsButton.layer.cornerRadius = settingsButton.frame.width/2
    }
    

}

