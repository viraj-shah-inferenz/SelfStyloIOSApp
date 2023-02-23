//
//  EyelinerStyleViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 23/01/23.
//

import UIKit

class EyelinerStyleViewController: UIViewController {

    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    @IBOutlet weak var colorNameCollectionView: UICollectionView!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    var backToCategory : (()-> Void)?
    var backToEyeliner : (()-> Void)?
    
    var apiUtils = ApiUtils()
    
    var makeup = MakeDetails()
    
    var arrCategory = [Category]()
    var arrProduct = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        reloadCollectionViewData()
        btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
        
        DispatchQueue.global(qos: .background).async {
            self.apiUtils.fetchMakeupDetails { makeupDetails in
                DispatchQueue.main.sync {
                    if let mkup = makeupDetails {
                        self.makeup = mkup
                        if self.makeup.data?.makeup?.count ?? 0 > 0 {
                            self.setEyelinerColorData()
                        }
                    }
                }
            }
        }
    }
    
    func setEyelinerColorData() {
        arrCategory.removeAll()
        arrProduct.removeAll()
        
        if let makeup = self.makeup.data?.makeup{
            for makeUp in makeup {
                if makeUp.makeupName == "Eyeliner" {
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
    func reloadCollections() {
        arrProduct.removeAll()
        if let product = arrCategory[0].products {
            for p in product {
                arrProduct.append(p)
            }
        }
        setDelegates()
        self.colorNameCollectionView.reloadData()
        self.productListCollectionView.reloadData()
    }
    func setCategory(categoryIndex: Int) {
        arrProduct.removeAll()
        if let product = arrCategory[categoryIndex].products {
            for p in product {
                arrProduct.append(p)
            }
        }
        self.productListCollectionView.reloadData()
    }
    
    func reloadCollectionViewData() {
        self.productListCollectionView.reloadData()
        self.colorNameCollectionView.reloadData()
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        backToCategory?()
    }
    
    
    @IBAction func btnChangeStyle(_ sender: UIButton) {
        backToEyeliner?()
    }
    
    func setDelegates() {
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
        
        colorNameCollectionView.delegate = self
        colorNameCollectionView.dataSource = self
    }
    
    @IBAction func btnSelectCheckbox(_ sender: UIButton) {
        if btnCheckbox.isSelected{
            btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
        }else {
            btnCheckbox.setImage(UIImage.init(named: "favourite_checked"), for: .normal)
        }
        btnCheckbox.isSelected = !btnCheckbox.isSelected
    }
}

extension EyelinerStyleViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        let cell = productListCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCodeCollectionViewCell", for: indexPath) as! ColorCodeCollectionViewCell
        
        cell.colorImage.clipsToBounds = true
        cell.colorImage.layer.cornerRadius = cell.colorImage.frame.width / 2
        
        let colornameCell = colorNameCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorNameCollectionViewCell", for: indexPath) as! ColorNameCollectionViewCell
        
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
//            NotificationCenter.default.post(name: NSNotification.Name("applyEyeliner"), object: arrProduct[indexPath.item])
            if arrCategory.count == 1 {
                NotificationCenter.default.post(name: NSNotification.Name("applyEyeliner"), object: arrProduct[indexPath.item], userInfo: ["category_name" : arrCategory[0].categoryName!])
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("applyEyeliner"), object: arrProduct[indexPath.item], userInfo: ["category_name" : arrCategory[indexPath.item].categoryName!])
            }
            
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

