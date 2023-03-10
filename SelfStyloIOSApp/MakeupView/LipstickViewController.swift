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
    
    @IBOutlet weak var btnClear: UIButton!
    
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    @IBOutlet weak var lblShadeName: UILabel!
    
    var backToCategory : (()-> Void)?

    var apiUtils = ApiUtils()
    
    
    
    var makeup = MakeDetails()
    
    var arrCategory = [Category]()
    var arrProduct = [Product]()
    
    var strCategory: String = ""
    var strProduct: String = ""
    var strProductId: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.productListCollectionView.register(UINib(nibName: "ColorCodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorCodeCollectionViewCell")

        self.colorNameCollectionView.register(UINib(nibName: "ColorNameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ColorNameCollectionViewCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
        
        
        
//        reloadCollectionViewData()
      
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
                        if let cat = arrCategory.first?.categoryName {
                            strCategory = cat
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
    
    func setDelegates() {
        productListCollectionView.delegate = self
        productListCollectionView.dataSource = self
        
        colorNameCollectionView.delegate = self
        colorNameCollectionView.dataSource = self
    }
    
    
    @IBAction func clearMakeupAction(_ sender: UIButton) {
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
        
        NotificationCenter.default.post(name: NSNotification.Name("clear_makeup"), object: nil, userInfo: ["makeupName" : "Lipstick"])
    }
    
    @IBAction func btnSelectCheckbox(_ sender: UIButton) {
        if btnCheckbox.isSelected{
            btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
        }else
        {
            btnCheckbox.setImage(UIImage.init(named: "favourite_checked"), for: .normal)
            
            let api = IApiCalls()
            let uuid = "4aa6223c-8439-4ed3-8de0-f6a67b1d36bd"  //UUID().uuidString
            let apiUrl = ApiUtils.MAKEUP_URL + api.like_product + "?id=\(uuid)&product_id=\(strProductId)"
            print(apiUrl)
            if strProduct == "" {
                print("Select make-up")
            } else {
                apiUtils.makeRequest(fronUrl: apiUrl) { Result in
                    switch Result {
                        
                    case .success(let data):
                        let res = String(data: data, encoding: .utf8)
                        print(res)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    
                }
            }
            
        }
        btnCheckbox.isSelected = !btnCheckbox.isSelected
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
        
        if collectionView.tag == 0 {
            let cell: ColorCodeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCodeCollectionViewCell", for: indexPath) as! ColorCodeCollectionViewCell
            
            cell.colorImage.clipsToBounds = true
            cell.colorImage.layer.cornerRadius = cell.colorImage.frame.width / 2
            
            if arrProduct.count > 0 {
                let data = arrProduct[indexPath.item]
//                print(data.colorCode)
                
                cell.colorImage.backgroundColor = data.colorCode?.rgbToColor()
                
                if data.productLiked == true {
                    cell.colorImage.layer.borderColor = UIColor.red.cgColor
                    cell.colorImage.layer.borderWidth = 1.0
                } else {
                    cell.colorImage.layer.borderColor = UIColor.clear.cgColor
                    cell.colorImage.layer.borderWidth = 0.0
                }
                if data.colorName == strProduct {
                    cell.colorImage.layer.borderColor = UIColor.white.cgColor
                    cell.colorImage.layer.borderWidth = 1.0
                } else {
                    cell.colorImage.layer.borderColor = UIColor.clear.cgColor
                    cell.colorImage.layer.borderWidth = 0.0
                }
            }
            return cell
        } else if collectionView.tag == 1 {
            let colornameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorNameCollectionViewCell", for: indexPath) as! ColorNameCollectionViewCell
            if arrCategory.count > 0 {
                let data = arrCategory[indexPath.item]
                if data.categoryName == strCategory {
                    colornameCell.lblcolor_name.textColor = UIColor.white
                } else {
//                    5E616D
                    colornameCell.lblcolor_name.textColor = UIColor.gray
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
            btnClear.setImage(UIImage(named: "clear_makeup"), for: .normal)
            NotificationCenter.default.post(name: NSNotification.Name("applyLipstick"), object: arrProduct[indexPath.item], userInfo: ["category_name" : strCategory])
            
            let product = arrProduct[indexPath.item]
            strProduct = product.colorName ?? ""
            if let pID = product.id {
                strProductId = String(pID)
            } else {
                print("product id is empty")
            }
            
            lblShadeName.text = product.colorName
            collectionView.reloadData()
            
        } else if collectionView.tag == 1 {
            // Category name
            let data = arrCategory[indexPath.item]
            strCategory = data.categoryName ?? ""
            setCategory(categoryIndex: indexPath.item)
            collectionView.reloadData()
            
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let bounds = collectionView.bounds
//        return CGSize(width: bounds.width/2 - 25, height: bounds.height)
//    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 16)
    }
}
