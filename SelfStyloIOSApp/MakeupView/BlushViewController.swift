//
//  BlushViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 23/01/23.
//

import UIKit

class BlushViewController: UIViewController {
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    @IBOutlet weak var colorNameCollectionView: UICollectionView!
    
    @IBOutlet weak var btnClear: UIButton!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    var apiUtils = ApiUtils()
    
    var makeup = MakeDetails()
    
    var arrCategory = [Category]()
    var arrProduct = [Product]()
    
    var backToCategory : (()-> Void)?
    
    var strBlushCategory:String = ""
    var strBlushProduct:String = ""
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
                            self.setBlushData()
                        }
                    }
                }
            }
        }
    }
    
    func setBlushData() {
        arrCategory.removeAll()
        arrProduct.removeAll()
        
        if let makeup = self.makeup.data?.makeup{
            for makeUp in makeup {
                if makeUp.makeupName == "Blush" {
                    if let category = makeUp.category {
                        for cat in category {
                            arrCategory.append(cat)
                        }
                        if let cat = arrCategory.first?.categoryName {
                            strBlushCategory = cat
                        }
                    }
                }
            }
        }
        reloadCollections()
    }
    
    func reloadCollectionViewData() {
        self.productListCollectionView.reloadData()
        self.colorNameCollectionView.reloadData()
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        backToCategory?()
    }
    
    func setDelegates()
    {
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
        
        colorNameCollectionView.delegate = self
        colorNameCollectionView.dataSource = self
    }
    
    @IBAction func btnSelectCheckbox(_ sender: UIButton) {
        if btnCheckbox.isSelected{
            btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
        }else
        {
            btnCheckbox.setImage(UIImage.init(named: "favourite_checked"), for: .normal)
        }
        btnCheckbox.isSelected = !btnCheckbox.isSelected
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
    
    @IBAction func clearMakeupAction(_ sender: UIButton) {
        btnClear.setImage(UIImage(named: "clear_makeup_select"), for: .normal)
        strBlushCategory = ""
        strBlushProduct = ""
        colorNameCollectionView.reloadData()
        productListCollectionView.reloadData()
        
        NotificationCenter.default.post(name: NSNotification.Name("clear_makeup"), object: nil, userInfo: ["makeupName" : "Blush"])
        
    }
    
}

extension BlushViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
                
                if data.colorName == strBlushProduct {
                    cell.colorImage.layer.borderColor = UIColor.white.cgColor
                    cell.colorImage.layer.borderWidth = 1.0
                } else {
                    cell.colorImage.layer.borderColor = UIColor.clear.cgColor
                    cell.colorImage.layer.borderWidth = 0.0
                }
                
                cell.colorImage.backgroundColor = data.colorCode?.rgbToColor()
            }
            return cell
        } else if collectionView.tag == 1 {
            if arrCategory.count > 0 {
                let data = arrCategory[indexPath.item]
                
                if data.categoryName == strBlushCategory {
                    colornameCell.lblcolor_name.textColor = UIColor.white
                } else {
//                    5E616D
                    colornameCell.lblcolor_name.textColor = UIColor.gray
                }
                
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
//            NotificationCenter.default.post(name: NSNotification.Name("applyBlush"), object: arrProduct[indexPath.item])
            btnClear.setImage(UIImage(named: "clear_makeup"), for: .normal)
            if arrCategory.count == 1 {
                NotificationCenter.default.post(name: NSNotification.Name("applyBlush"), object: arrProduct[indexPath.item], userInfo: ["category_name" : arrCategory[0].categoryName!])
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("applyBlush"), object: arrProduct[indexPath.item], userInfo: ["category_name" : strBlushCategory])
            }
            let data = arrProduct[indexPath.item]
            strBlushProduct = data.colorName ?? ""
            collectionView.reloadData()
        } else if collectionView.tag == 1 {
            // Category name
            let data = arrCategory[indexPath.item]
            strBlushCategory = data.categoryName ?? ""
            setCategory(categoryIndex: indexPath.item)
            collectionView.reloadData()
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
