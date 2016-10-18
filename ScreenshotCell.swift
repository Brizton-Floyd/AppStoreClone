//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/18/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import UIKit

class ScreenshotCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    
    var app: App? {
        
        didSet {
            collectionview.reloadData()
        }
    }
    
    
    let divider: UIView = {
        
        let div = UIView()
        div.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return div
    }()
    
    lazy var collectionview: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.dataSource = self
        view.delegate = self
        view.register(ScreenShotImageCell.self, forCellWithReuseIdentifier: self.cellId)
        
        return view
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShotImageCell
        
        if let image = app?.screenshots?[indexPath.item] {
            
            cell.imageView.image = UIImage(named: image)
        }
        
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count =  app?.screenshots?.count {
            
            return count
        }
        
        return 0
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 300, height: frame.height - 20)
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        
        addSubview(collectionview)
        addSubview(divider)
        
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: collectionview)
        addConstraintsWithVisualFormat(format: "V:|[v0][v1(1)]|", views: collectionview,divider)
        
        addConstraintsWithVisualFormat(format: "H:|-14-[v0]|", views: divider)

    }
    
    private class ScreenShotImageCell: UICollectionViewCell {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUpViews()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = UIColor.green
            return iv
        }()
        
        
        
        func setUpViews() {
            
            layer.masksToBounds = true
            addSubview(imageView)
            
            addConstraintsWithVisualFormat(format: "H:|[v0]|", views: imageView)
            addConstraintsWithVisualFormat(format: "V:|[v0]|", views: imageView)
        }
    }
}
