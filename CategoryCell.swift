//
//  CategoryCell.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/7/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import UIKit

// this class will represent the cells data that gets populated
class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let appCellId = "appCellId"
    
    // Property that will allow the cells to call the show app function in the featured apps controller class
    var featuredAppsController: FeaturedAppsController?
    
    // once the cell is dequed this property will be called and if a value was assign when the didSet will execute and assign the value to the nameLabel.text property    
    var appCategory: AppCategory? {
        didSet {
            
            if let name = appCategory?.name {
                nameLabel.text = name
            }
            
            appsCollectionView.reloadData()
        }
    }
    
    
    // Each time a cell is dequed from a collection view this method will be called in order to properly set up the cells appropriately
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerLineView: UIView = {
        let divider = UIView()
        divider.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    
    // here we will set up a collection view within an already defined cell
    lazy var appsCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self

        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }()
    
    func setUpViews() {
        
        backgroundColor = UIColor.clear
    
        addSubview(appsCollectionView)
        addSubview(dividerLineView)
        addSubview(nameLabel)

        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: appCellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        
        //This contraint is here to positon the subviews vertically. Pretty much the same appoach as above
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView, "v1":dividerLineView, "nameLabel":nameLabel]))
        
    }
    
    // this funciton will alllow the ability to perform a seque programatically 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let app = appCategory?.apps?[indexPath.item] {
            
            featuredAppsController?.showAppDetailForApp(app: app)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = appCategory?.apps?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = appsCollectionView.dequeueReusableCell(withReuseIdentifier: appCellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}
