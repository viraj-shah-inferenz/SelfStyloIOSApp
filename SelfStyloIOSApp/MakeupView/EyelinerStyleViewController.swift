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
    
    @IBOutlet weak var btnClear: UIButton!
    
    @IBOutlet weak var lblShadeName: UILabel!
    
    var backToCategory : (()-> Void)?
    var backToEyeliner : (()-> Void)?
    
    var apiUtils = ApiUtils()
    
    var makeup = MakeDetails()
    
    var arrCategory = [Category]()
    var arrProduct = [Product]()
    
    var strCategory: String = ""
    var strProduct: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.productListCollectionView.register(UINib(nibName: "ColorCodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCodeCollectionViewCell")

        self.colorNameCollectionView.register(UINib(nibName: "ColorNameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorNameCollectionViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
//        reloadCollectionViewData()
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
    
    
    @IBAction func clearMakeup(_ sender: UIButton) {
        btnClear.setImage(UIImage(named: "clear_makeup_select"), for: .normal)
        
//        strCategory = ""
        strProduct = ""
        
        if let cat = arrCategory[0].categoryName {
            strCategory = cat
        }
        setCategory(categoryIndex: 0)
        lblShadeName.text = "select a shade"
        colorNameCollectionView.reloadData()
        productListCollectionView.reloadData()
        
        NotificationCenter.default.post(name: NSNotification.Name("clear_makeup"), object: nil, userInfo: ["makeupName" : "Eyeliner"])
    }
    
    func setEyelinerColorData() {
        arrCategory.removeAll()
        arrProduct.removeAll()
        
        if let makeup = self.makeup.data?.makeup{
            for makeUp in makeup {
                if makeUp.makeupName == "Eyeliner" {
                    if let category = makeUp.category {
                        if category.count > 0 {
                            for cat in category {
                                arrCategory.append(cat)
                            }
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
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            
            let cell: ColorCodeCollectionViewCell = productListCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCodeCollectionViewCell", for: indexPath) as! ColorCodeCollectionViewCell
            
            cell.colorImage.clipsToBounds = true
            cell.colorImage.layer.cornerRadius = cell.colorImage.frame.width / 2
            
            if arrProduct.count > 0 {
                let data = arrProduct[indexPath.item]
                
                if data.colorName == strProduct {
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
            
            let colornameCell: ColorNameCollectionViewCell = colorNameCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorNameCollectionViewCell", for: indexPath) as! ColorNameCollectionViewCell
            
            if arrCategory.count > 0 {
                let data = arrCategory[indexPath.item]
                if arrCategory.count == 1 {
                    colornameCell.lblcolor_name.textColor = UIColor.white
                } else {
                    if data.categoryName == strCategory {
                        colornameCell.lblcolor_name.textColor = UIColor.white
                    } else {
    //                    5E616D
                        colornameCell.lblcolor_name.textColor = UIColor.gray
                    }
                }
                
                colornameCell.lblcolor_name.text = data.categoryName
            }
            return colornameCell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            // product color
//            NotificationCenter.default.post(name: NSNotification.Name("applyEyeliner"), object: arrProduct[indexPath.item])
            if arrCategory.count == 1 {
                btnClear.setImage(UIImage(named: "clear_makeup"), for: .normal)
                NotificationCenter.default.post(name: NSNotification.Name("applyEyeliner"), object: arrProduct[indexPath.item], userInfo: ["category_name" : arrCategory[0].categoryName!])
            } else {
                NotificationCenter.default.post(name: NSNotification.Name("applyEyeliner"), object: arrProduct[indexPath.item], userInfo: ["category_name" : arrCategory[indexPath.item].categoryName!])
            }
            let data = arrProduct[indexPath.item]
            strProduct = data.colorName ?? ""
            lblShadeName.text = data.colorName
            collectionView.reloadData()
        } else if collectionView.tag == 1 {
            // Category name
            let data = arrCategory[indexPath.item]
            strCategory = data.categoryName ?? ""
            setCategory(categoryIndex: indexPath.item)
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 25, height: bounds.height)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.tag == 0 {
            return 25.0
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        if collectionView.tag == 1 {
            let totalCellWidth = 124 * collectionView.numberOfItems(inSection: 0)
            let totalSpacingWidth = 0 * (collectionView.numberOfItems(inSection: 0) - 1)
            

            let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset

            print(leftInset)
            

            return UIEdgeInsets(top: 0, left: leftInset + 32, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets.zero
        }
    }
}

