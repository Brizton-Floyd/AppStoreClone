//
//  AppDetailController.swift
//  AppStoreClone
//
//  Created by brizton floyd on 10/17/16.
//  Copyright © 2016 brizton floyd. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let cellId = "cellId"
    let descId = "descId"
    
    var app: App? {
        
        didSet {
            
            if app?.screenshots != nil {
                return
            }
            
            if let id = app?.id {
            
                let urlString = "http://www.statsallday.com/appstore/appdetail?id=\(id)"
                
                URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
                    
                    if error != nil {
                        print(error)
                    }
                    
                    do {
                        
                        let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [String:AnyObject]
                        
                        let appDetail = App()
                        
                        appDetail.setValuesForKeys(json)
                        
                        self.app = appDetail
                        
                        DispatchQueue.main.async(execute: {
                            
                            self.collectionView?.reloadData()
                            
                        })
                        
                    }catch let err {
                        print(err)
                    }
                }).resume()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: descId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppDetailHeader
        
        header.app = app
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            let estimateSize = CGSize(width: view.frame.width - 8 - 8, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = descriptionAttributedText().boundingRect(with: estimateSize, options: options, context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 30)
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.item == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descId, for: indexPath) as! AppDetailDescriptionCell
            
            cell.textview.attributedText = descriptionAttributedText()
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell
        
        cell.app = app
        
        return cell
    }
    // this is how to return the size for headr in a collecion view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        return CGSize(width: view.frame.width, height: 170)
    }
    
    // similar to a string builder that allows to append different text
    private func descriptionAttributedText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "Description\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedString.string.characters.count)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        if let desc = app?.desc {
            
            attributedString.append(NSAttributedString(string: desc, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 11),NSForegroundColorAttributeName:UIColor.darkGray]))
        }
        
        return attributedString
    }
}

class AppDetailHeader: UICollectionViewCell {
    
    var app: App? {
        
        didSet {
            
            if let imageName = app?.imageName {
                
                iv.image = UIImage(named: imageName)
            }
            
            if let appName = app?.name {
                nameLabel.text = appName
            }
            
            if let price = app?.price {
                
                button.setTitle("$\(price)", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let iv: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 16
        return iv
        
    }()
    
    let segmentedControl: UISegmentedControl = {
        
        let control = UISegmentedControl(items: ["Details","Reviews","Related"])
        control.tintColor = UIColor.darkGray
        control.selectedSegmentIndex = 0
        
        return control
    }()
    
    let nameLabel: UILabel = {
       
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
        
    }()
    
    let button: UIButton = {
       
        let buyButton = UIButton(type: .system)
        buyButton.setTitle("Buy", for: .normal)
        buyButton.layer.borderColor = UIColor(colorLiteralRed: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        buyButton.layer.cornerRadius = 5
        buyButton.layer.borderWidth = 1
        return buyButton
    }()
    
    let divider: UIView = {
        
        let div = UIView()
        div.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return div
    }()
    
    func setUpViews() {
        
        addSubview(iv)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(button)
        addSubview(divider)
        
        addConstraintsWithVisualFormat(format: "H:|-14-[v0(100)]-8-[v1]|", views: iv,nameLabel)
        addConstraintsWithVisualFormat(format: "V:|-14-[v0(100)]", views: iv)
        addConstraintsWithVisualFormat(format: "V:|-14-[v0(20)]", views: nameLabel)
        
        addConstraintsWithVisualFormat(format: "H:[v0(50)]-14-|", views: button)
        addConstraintsWithVisualFormat(format: "V:[v0(20)]-8-[v1(30)]-8-[v2(1)]|", views: button, segmentedControl,divider)
        addConstraintsWithVisualFormat(format: "H:|-40-[v0]-40-|", views: segmentedControl)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: divider)
    }
    
}





