//
//  SavedForLaterCell.swift
//  ead
//
//  Created by Alex on 05/08/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

class SavedForLaterCell: UITableViewCell {

    @IBOutlet weak var nameOfArticle: UILabel!
    @IBOutlet weak var dateDaysRemained: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
