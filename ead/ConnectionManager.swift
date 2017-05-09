//
//  ConnectionManager.swift
//  ead
//
//  Created by Alex on 03/08/16.
//  Copyright © 2016 orgname. All rights reserved.
//

import UIKit
import Foundation


protocol ConnectionManagerProtocol {
    func didFinishDownloadResources()
}

class ConnectionManager: NSObject {  // Singleton
    
    static let sharedInstance = ConnectionManager()
    fileprivate override init() {}
    
    var connectionManagerDelegate:ConnectionManagerProtocol!
    
    func downloadResources() {
        
        
        let url1:URL!
        var task1:URLSessionDataTask!
        var task2:URLSessionDataTask!
        
        url1 = URL(string: "http://getead.com/api.php")
        
        let urlPath2:String = "http://getead.com/splash-image.php"
        let url2:URL = URL(string: urlPath2)!
        let session = URLSession.shared
        let request2 = NSMutableURLRequest(url: url2)
        
        let priority = DispatchQueue.GlobalQueuePriority.default
        DispatchQueue.global(priority: priority).async {
            
            task1 = URLSession.shared.dataTask(with: url1, completionHandler: { (data, response, error) in
                
                ApplicationDataManager.sharedInstance.dataFromServer = data
                
                DispatchQueue.main.async(execute: {
                    self.connectionManagerDelegate.didFinishDownloadResources()
                })
    
            })
            
            
          
            task2 = session.dataTask(with: request2, completionHandler: { (data, response, error) in
                
                ApplicationDataManager.sharedInstance.dataImageFromServer = data
                
               
                
            }) 
            
        task1.resume()
        task2.resume()
            
        
        }
    }
    
    
    func registerUser( _ firstName: String, lastName: String, email: String, password: String, dateOB: String ){
        
        let headers = [
            "cache-control": "no-cache",
            "postman-token": "55d85b66-83f2-7650-1580-db48023b823c",
            "content-type": "application/x-www-form-urlencoded"
        ]
        
        var postData = NSData(data: "first_name=\(firstName)".data(using: String.Encoding.utf8)!) as Data
        postData.append("&last_name=\(lastName)".data(using: String.Encoding.utf8)!)
        postData.append("&dob=\(dateOB)".data(using: String.Encoding.utf8)!)
        postData.append("&profile_picture=null".data(using: String.Encoding.utf8)!)
        postData.append("&facebook_id=null".data(using: String.Encoding.utf8)!)
        postData.append("&email_address=\(email)".data(using: String.Encoding.utf8)!)
        postData.append("&password=\(password)".data(using: String.Encoding.utf8)!)
        
       // var requestString = NSString(data: postData, encoding: NSUTF8StringEncoding)
        
        var request = NSMutableURLRequest(url: URL(string: "http://getead.com/user.php?action=register")!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
            
        })
        
        dataTask.resume()
    
    }
    
    

}
