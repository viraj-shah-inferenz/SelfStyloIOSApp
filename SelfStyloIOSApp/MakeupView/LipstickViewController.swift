//
//  ProductListViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 20/01/23.
//

import UIKit

class LipstickViewController: UIViewController {
    
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    @IBOutlet weak var colorNameCollectionView: UICollectionView!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    var backToCategory : (()-> Void)?
    
<<<<<<< HEAD
    var color_image:[String] = ["color_code_circle", "color_code_circle","color_code_circle", "color_code_circle","color_code_circle"]
   
    var color_name:[String] =  ["Pomegranate","RoseWood","RoseWood Gloss","Pomegranate Glitter","Metallic","Bossom"]
=======
    var apiUtils = ApiUtils()
    
    var makeup = MakeDetails()
    
    var arrCategory = [Category]()
    var arrProduct = [Product]()
>>>>>>> 1d86fa1 (add makeup feature like:- Lipstick, Eyeshadow, Blush)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadCollectionViewData()
        btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
<<<<<<< HEAD
       
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
=======
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
>>>>>>> 1d86fa1 (add makeup feature like:- Lipstick, Eyeshadow, Blush)
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
}

extension LipstickViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
<<<<<<< HEAD




=======
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
    
>>>>>>> 1d86fa1 (add makeup feature like:- Lipstick, Eyeshadow, Blush)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 25, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
}
