//
//  AppDetailDescriptionCell.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/18/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import UIKit

class AppDetailDescriptionCell : UICollectionViewCell {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textview: UITextView = {
        
        let tv = UITextView()
        tv.isEditable = false
        tv.text = "Sample Description"
        
        return tv
    }()
    
    let divider: UIView = {
        
        let div = UIView()
        div.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return div
    }()
    
    func setUpViews() {
        
        addSubview(textview)
        addSubview(divider)
        
        addConstraintsWithVisualFormat(format: "H:|-8-[v0]-8-|", views: textview)
        addConstraintsWithVisualFormat(format: "V:|-4-[v0]-4-[v1(1)]|", views: textview,divider)
        
        addConstraintsWithVisualFormat(format: "H:|-14-[v0]|", views: divider)

    }
    
}
