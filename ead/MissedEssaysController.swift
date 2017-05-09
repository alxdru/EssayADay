//
//  MissedEssaysController.swift
//  ead
//
//  Created by Alex on 28/07/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

class MissedEssaysController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.action = #selector(self.backFunction)
        backButton.target = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backFunction(){
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
