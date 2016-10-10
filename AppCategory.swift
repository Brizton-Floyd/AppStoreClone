//
//  AppCategory.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/8/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

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
        
        Alamofire.request(APP_URL_STRING).responseJSON { response in
            let jsonResult = response.result
            
            if let dict = jsonResult.value as? Dictionary<String, AnyObject> {
                
                 let featuredApps = FeaturedApps()
                
                // here we will parse the entire json object and set properties dynamically based on key input
                 featuredApps.setValuesForKeys(dict)
                 completionHandler(featuredApps)
            }
        }
    }
}
