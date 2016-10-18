//
//  App.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/8/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import Foundation
import UIKit

class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?

    var screenshots: [String]?
    var appInformation: AnyObject?
    var desc: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "description" {
            self.desc = value as? String
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
}
