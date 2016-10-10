//
//  ViewController.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/7/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout{


    fileprivate let cellID = "cellID"
    
    // set up an array that will hold our app categories so we know how many items to specify in numberofitems in section for eact app category
    var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AppCategory.fetchFeaturedApps { (appCategories) in
            self.appCategories = appCategories
            self.collectionView?.reloadData()
        }

        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count{
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        
        // once the cell in dequed we will set the appcategory based on the category in the appcategory array
        cell.appCategory = appCategories?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
}

