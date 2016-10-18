//
//  AppCategory.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/8/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import UIKit
import Foundation


class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            
            
            apps = [App]()
            for dict in value as! [[String:AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
        }
        else
        {
            super.setValue(value, forKey: key)
        }
    }
    // there is also completein handler available in the Constants file
    static func fetchFeaturedApps(completionHandler: @escaping (FeaturedApps) -> ()) {
        
        let url = URL(string: APP_URL_STRING)
        
        
        
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error)
            }
            
            do {
                
                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String:AnyObject]
                
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeys(json)
                
                DispatchQueue.main.async(execute: { 
                   
                    completionHandler(featuredApps)
                    
                })

            }catch let err {
                print(err)
            }
            

            
            

        }.resume()
        
    }
}
