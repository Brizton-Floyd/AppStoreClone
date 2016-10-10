//
//  BannerCell.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/10/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import Foundation
import UIKit

class BannerCell: AppCell {
   
    override func setUpViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
       
        imageView.layer.cornerRadius = 0
        addSubview(imageView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : imageView]))
    }
}
