//
//  LargeCategoryCell.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/10/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import Foundation
import UIKit

class LargeCategoryCell: CategoryCell {
    
    private let largeAppCell = "largeAppCell"
    
    override func setUpViews() {
        super.setUpViews()
        super.appsCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: largeAppCell)
    }
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = CGSize(width: 200, height: frame.height - 32)
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = appsCollectionView.dequeueReusableCell(withReuseIdentifier: largeAppCell, for: indexPath) as! LargeAppCell
        cell.app = appCategory?.apps?[indexPath.item]
        
        return cell
    }
}
