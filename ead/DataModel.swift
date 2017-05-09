//
//  DataModel.swift
//  ead
//
//  Created by Alex on 05/08/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit

class DataModel: NSObject {

    var profileImageURL:String!
    var profileFirstName:String!
    var profileLastName:String!
    var profileEmail:String!
    var profileDateOfBirth:String!
    var profileName:String!
    var profileAgeRange:Int!
    
    override init(){
    
        profileImageURL = ""
        profileEmail = ""
        profileFirstName = ""
        profileLastName = ""
        profileName = ""
        profileDateOfBirth = ""
        profileAgeRange = nil
    
    }
    
    func resetToNull(){
        
        profileImageURL = ""
        profileEmail = ""
        profileFirstName = ""
        profileLastName = ""
        profileName = ""
        profileDateOfBirth = ""
        profileAgeRange = nil
    
    }
    
}
