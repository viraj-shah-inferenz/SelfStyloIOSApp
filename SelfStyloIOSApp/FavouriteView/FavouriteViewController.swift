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
    var apiUtils = ApiUtils()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        btnHomeView.addTarget(self, action: #selector(BackHome(sender: )), for: .touchUpInside)
        let db = FavouriteProductDao()
        favourite_product = db.getAll()
        apiUtils.getFavouriteProductDetail()
    }
    
    @objc func BackHome(sender: UIButton){
        self.tabBarController?.selectedIndex = 0
    }
    
    
}

extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourite_product.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(1) as? UILabel{
            vc.text = favourite_product[indexPath.row].categoryName
        } else if let vc = cell.viewWithTag(2) as? UILabel{
            vc.text = favourite_product[indexPath.row].brandName
        } else if let vc = cell.viewWithTag(3) as? UIImageView{
            let defaultLink = ""
            let completeLink1 = defaultLink + favourite_product[indexPath.row].brandLogoUrl
            vc.image = UIImage(named: completeLink1)
        } else if let vc = cell.viewWithTag(4) as? UILabel{
            vc.text = favourite_product[indexPath.row].colorName
        }else if let color_code = cell.viewWithTag(5) as? UIImageView{
            color_code.backgroundColor = favourite_product[indexPath.row].colorCode.rgbToColor()
            color_code.layer.cornerRadius = 25
            color_code.layer.masksToBounds = false
            color_code.clipsToBounds = true
        }
        
       cell.contentView.layer.cornerRadius = 24
        cell.contentView.layer.borderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7).cgColor 
        cell.contentView.layer.borderWidth = 1
        return cell
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
