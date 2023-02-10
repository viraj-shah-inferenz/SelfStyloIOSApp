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
        self.FavouriteCollectionView.reloadData()
    }
    
    func refreshBannerList(bannerList: [Banner]) {
        
    }
    

    

    @IBOutlet weak var btnHomeView: UIButton!
    @IBOutlet weak var FavouriteCollectionView: UICollectionView!

    
    var favourite_product : [FavouriteProducts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnHomeView.addTarget(self, action: #selector(BackHome(sender: )), for: .touchUpInside)
        let db = FavouriteProductDao()
      //  favourite_product = db.getAll()
        for products in db.getAll() {
            favourite_product.append(products)
        }
    }
    
    @objc func BackHome(sender: UIButton){
        self.tabBarController?.selectedIndex = 0
    }
    
    func setDelegates() {
        self.FavouriteCollectionView.delegate = self
        self.FavouriteCollectionView.dataSource = self
    }
    
    
}


extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourite_product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favouritecell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteViewCell", for: indexPath) as! FavouriteViewCell

        favouritecell.category_name.text = favourite_product[indexPath.row].categoryName
        favouritecell.brand_name.text = favourite_product[indexPath.row].brandName
        let defaultLink = ""
        let completeLink1 = defaultLink + favourite_product[indexPath.row].brandLogoUrl
       // favouritecell.brand_logo.DownloadedFrom(link: completeLink1)
        favouritecell.brand_logo.sd_setImage(with: URL(string: completeLink1))
        favouritecell.color_name.text = favourite_product[indexPath.row].colorName
        favouritecell.color_code.backgroundColor = favourite_product[indexPath.row].colorCode.rgbToColor()
        favouritecell.color_code.layer.cornerRadius = 7
        favouritecell.color_code.layer.masksToBounds = false
        favouritecell.color_code.clipsToBounds = true
        favouritecell.sub_category_name.text = favourite_product[indexPath.row].subCategoryName
           favouritecell.contentView.layer.cornerRadius = 24
           favouritecell.contentView.layer.borderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7).cgColor
           favouritecell.contentView.layer.borderWidth = 1
           return favouritecell
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    

}






extension FavouriteViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = FavouriteCollectionView.bounds
        return CGSize(width: bounds.width/2 - 20, height: bounds.height/4)
    }

}
