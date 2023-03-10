//
//  FavouriteProductTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import UIKit

class FavouriteProductTableViewCell: UITableViewCell {
    
    var favouriteProductData = [FavouriteProductData]()
    
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    @IBOutlet weak var btnFavouriteDetails: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.favouriteCollectionView.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteCollectionViewCell")
        setDelegates()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadFavouriteData(notification:)), name: Notification.Name("loadFavouriteItem"), object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDelegates() {
        self.favouriteCollectionView.delegate = self
        self.favouriteCollectionView.dataSource = self
        
    }
    
    @objc
    func loadFavouriteData(notification: Notification) {
        let favouriteProduct = notification.object as! [FavouriteProductData]
        
        
        
        for i in 0..<favouriteProduct.count {
            if i < 3 {
                favouriteProductData.append(favouriteProduct[i])
            }
        }
        favouriteCollectionView.reloadData()
    }
}

extension FavouriteProductTableViewCell: FavouriteDataDelegate {
    func refreshData(data: [FavouriteProductData]) {
        favouriteProductData = data
        favouriteCollectionView.reloadData()
    }
}

extension FavouriteProductTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteProductData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell
        let data = favouriteProductData[indexPath.item]
        
        cell.category_name.text = data.category
        cell.brand_name.text = data.companyName
        cell.color_name.text = data.colorName
        cell.sub_category_name.text = data.subcategory
        cell.color_code.backgroundColor = data.colorCode?.rgbToColor()
        
        cell.color_code.layer.cornerRadius = cell.color_code.layer.bounds.height / 2
        cell.color_code.clipsToBounds = true
        
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.clipsToBounds = true
        
        if let category = data.category {
            if category == "Foundation" {
                cell.category_logo.image = UIImage(named: "foundation")
            } else if category == "Lipstick" {
                cell.category_logo.image = UIImage(named: "lipstick_icon")
            } else if category == "Blush" {
                cell.category_logo.image = UIImage(named: "blush")
            } else if category == "Eyeliner" {
                cell.category_logo.image = UIImage(named: "eyeliner")
            } else if category == "Eyeshadow" {
                cell.category_logo.image = UIImage(named: "eyeshadow")
            } else {
                cell.category_logo.image = UIImage(named: "lipstick_icon")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 20, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 44)
    }
}
