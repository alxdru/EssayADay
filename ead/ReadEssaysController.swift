//
//  ReadEssaysController.swift
//  ead
//
//  Created by Alex on 28/07/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

class ReadEssaysController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class ReadEssaysCell: UITableViewCell {
    
    
    @IBOutlet var nameOfArticle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



extension ReadEssaysController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ReadEssaysCell = tableView.dequeueReusableCell(withIdentifier: "ReadEssaysCell") as! ReadEssaysCell
        
        cell.nameOfArticle.text = "Article name"
        
        return cell;
    }
}
