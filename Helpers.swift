//
//  Helpers.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/17/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsWithVisualFormat(format: String, views: UIView...) {
        
        var viewDictionary = [String:UIView]()
        
        for (index, view) in views.enumerated() {
            
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}
