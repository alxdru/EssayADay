//
//  AlertViewController.swift
//  ead
//
//  Created by Alex on 02/08/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit


protocol AlertViewControllerProtocol{
    func continueButtonPressed()
}

class AlertViewController: UIViewController {

    @IBOutlet weak var gemsCount: UILabel!
    @IBOutlet weak var bonusCount: UILabel!
    @IBOutlet weak var totalCount: UILabel!
    
    var alertViewControllerDelegate: AlertViewControllerProtocol!
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueButtonTapped(_ sender: AnyObject) {
        
        alertViewControllerDelegate.continueButtonPressed()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        continueButton.layer.cornerRadius = 6
        alertView.layer.cornerRadius = 20
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
