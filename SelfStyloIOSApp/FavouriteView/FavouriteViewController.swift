//
//  FavouriteViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 27/12/22.
//

import UIKit


class FavouriteViewController: UIViewController,GetUsersDelegate {
    func refreshFavouriteProductsList(favouriteproductList: [FavouriteProducts]) {
        self.favourite_product = favouriteproductList
        self.favouriteCollectionView.reloadData()
    }
    
    func refreshBannerList(bannerList: [Banner]) {
        
    }
    
    
    
    
    @IBOutlet weak var btnHomeView: UIButton!
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    
    
    var favourite_product : [FavouriteProducts] = []
    
    var favouriteProductData = [FavouriteProductData]()
    
    var apiUtils = ApiUtils()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavouriteProducts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnHomeView.addTarget(self, action: #selector(BackHome(sender: )), for: .touchUpInside)
        
        
    }
    
    func loadFavouriteProducts() {
        let api = IApiCalls()
        let uuid = "4aa6223c-8439-4ed3-8de0-f6a67b1d36bd"  //UUID().uuidString
        let apiUrl = ApiUtils.MAKEUP_URL + api.product_like + "?id=\(uuid)"
        apiUtils.makeRequest(fronUrl: apiUrl) { Result in
            switch Result {
                
            case .success(let data):
                do {
                    let list = try? JSONDecoder().decode(FavouriteProducts.self, from: data)
                    if let list = list?.data {
                        self.favouriteProductData = list
                        DispatchQueue.main.async {
                            self.favouriteCollectionView.reloadData()
                        }
                    }
                } catch let error {
                    self.view.makeToast(error.localizedDescription, duration: 3.0, position: .bottom)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    @objc func BackHome(sender: UIButton){
        self.tabBarController?.selectedIndex = 0
    }
    
    @objc
    func loadFavouriteData(notification: Notification) {
        favouriteProductData = notification.object as! [FavouriteProductData]
        favouriteCollectionView.reloadData()
    }
    
    func setDelegates() {
        self.favouriteCollectionView.delegate = self
        self.favouriteCollectionView.dataSource = self
    }
}


extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteProductData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteViewCell", for: indexPath) as! FavouriteViewCell
        let data = favouriteProductData[indexPath.item]
        
        cell.category_name.text = data.category
        cell.brand_name.text = data.companyName
        cell.color_name.text = data.colorName
        cell.sub_category_name.text = data.subcategory
        cell.color_code.backgroundColor = data.colorCode?.rgbToColor()
        
        cell.brand_logo.isHidden = true
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = favouriteCollectionView.bounds
        return CGSize(width: bounds.width/2 - 20, height: bounds.height/4)
    }
    
}
