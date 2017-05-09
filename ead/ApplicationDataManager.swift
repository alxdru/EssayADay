//
//  ApplicationDataManager.swift
//  ead
//
//  Created by Alex on 04/08/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

class ApplicationDataManager: NSObject {

    static let sharedInstance = ApplicationDataManager()
    fileprivate override init() {
    
        dataModel = DataModel()
    
    }
    
    var dataFromServer:Data!
    var dataImageFromServer:Data!
    var dataModel:DataModel!
    
    
}
