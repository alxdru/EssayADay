//
//  SavedForLaterController.swift
//  ead
//
//  Created by Alex on 27/07/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

class SavedForLaterController: UIViewController{

    @IBOutlet weak var savedForLaterTable: UITableView!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savedForLaterTable.dataSource = self
        
        
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}




extension SavedForLaterController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SavedForLaterCell = tableView.dequeueReusableCell(withIdentifier: "SavedForLaterCell") as! SavedForLaterCell

        cell.nameOfArticle.text = "Article name"
        cell.dateDaysRemained.text = "12312331232"
        
        return cell;
    }
}
