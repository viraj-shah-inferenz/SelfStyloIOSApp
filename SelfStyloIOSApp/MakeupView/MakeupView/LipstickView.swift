//
//  LipstickView.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 27/01/23.
//

import UIKit

class LipstickView: UIView {

    @IBOutlet weak var colorCodeCollectionView: UICollectionView!
    
    @IBOutlet weak var backView: CardView!
    
    @IBOutlet weak var subCatNameCollectionView: UICollectionView!
    
    var apiUtils = ApiUtils()
    
    var makeup = MakeDetails()
    
    var arrCategory = [Category]()
    var arrProduct = [Product]()
    
    func setDelegates()
    {
        subCatNameCollectionView.delegate = self
        subCatNameCollectionView.dataSource = self
        
        colorCodeCollectionView.delegate = self
        colorCodeCollectionView.dataSource = self
    }
    func setupData() {
        self.colorCodeCollectionView.register(UINib(nibName: "ColorCodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCodeCollectionViewCell")
        
        self.subCatNameCollectionView.register(UINib(nibName: "ColorNameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorNameCollectionViewCell")
        
        DispatchQueue.global(qos: .background).async {
            self.apiUtils.fetchMakeupDetails { makeupDetails in
                DispatchQueue.main.sync {
                    if let mkup = makeupDetails {
                        self.makeup = mkup
                        if self.makeup.data?.makeup?.count ?? 0 > 0 {
                            self.setLipstickData()
                        }
                    }
                }
            }
        }
    }
    
    func setLipstickData() {
        arrCategory.removeAll()
        arrProduct.removeAll()
        
        if let makeup = self.makeup.data?.makeup{
            for makeUp in makeup {
                if makeUp.makeupName == "Lipstick" {
                    if let category = makeUp.category {
                        for cat in category {
                            arrCategory.append(cat)
                        }
                    }
                }
            }
        }
        reloadCollections()
    }
    
    func reloadCollectionViewData() {
        self.subCatNameCollectionView.reloadData()
        self.colorCodeCollectionView.reloadData()
    }
    
    func reloadCollections() {
        arrProduct.removeAll()
        if let product = arrCategory[0].products {
            for p in product {
                arrProduct.append(p)
            }
        }
        setDelegates()
        self.colorCodeCollectionView.reloadData()
        self.subCatNameCollectionView.reloadData()
    }
    func setCategory(categoryIndex: Int) {
        arrProduct.removeAll()
        if let product = arrCategory[categoryIndex].products {
            for p in product {
                arrProduct.append(p)
            }
        }
        self.subCatNameCollectionView.reloadData()
    }
}

extension LipstickView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            if arrProduct.count > 0 {
                return arrProduct.count
            } else {
                return 0
            }
        } else if collectionView.tag == 1 {
            if arrCategory.count > 0 {
                return arrCategory.count
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colorCodeCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCodeCollectionViewCell", for: indexPath) as! ColorCodeCollectionViewCell
        
        cell.colorImage.clipsToBounds = true
        cell.colorImage.layer.cornerRadius = cell.colorImage.frame.width / 2
        
        let colornameCell = subCatNameCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorNameCollectionViewCell", for: indexPath) as! ColorNameCollectionViewCell
        
        if collectionView.tag == 0 {
            if arrProduct.count > 0 {
                let data = arrProduct[indexPath.item]
                print(data.colorCode)
                cell.colorImage.backgroundColor = data.colorCode?.rgbToColor()
            }
            return cell
        } else if collectionView.tag == 1 {
            if arrCategory.count > 0 {
                let data = arrCategory[indexPath.item]
                colornameCell.lblcolor_name.text = data.categoryName
            }
            return colornameCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        if collectionView.tag == 0 {
            // product color
            NotificationCenter.default.post(name: NSNotification.Name("applyLipstick"), object: arrProduct[indexPath.item])
            
            
            
        } else if collectionView.tag == 1 {
            // Category name
            let data = arrCategory[indexPath.item]
            setCategory(categoryIndex: indexPath.item)
        } else {
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 25, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    
}
