//
//  FeaturedApp.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/10/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import Foundation
import UIKit

class FeaturedApps: NSObject{
    
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "categories" {
            
            appCategories = [AppCategory]()
            
            for dict in value as! [[String:AnyObject]]{
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
            }
        }
        else if key == "bannerCategory"
        {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String:AnyObject])
        }
        else{
            super.setValue(value, forKey: key)
        }
    }
}
