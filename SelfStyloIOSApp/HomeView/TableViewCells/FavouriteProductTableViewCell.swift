//
//  FavouriteProductTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import UIKit

class FavouriteProductTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,GetUsersDelegate {
    
    
    func refreshBannerList(bannerList: [Banner]) {
    }
    
//    var brandlogoArr = [UIImage(named: "brandlogo"),UIImage(named: "brandlogo"),UIImage(named: "brandlogo")]
//    var brand_name:[String] = ["Inferenz","Inferenz","Inferenz"]
//    var color_code = [UIImage(named: "color_code"),UIImage(named: "color_code"),UIImage(named: "color_code")]
//    var color_name:[String] = ["Red Pink","Red Pink","Red Pink"]
//    var category_name:[String] = ["Lipstick","Eyeliner","Blush"]
    
    var favourite_product:[FavouriteProducts] = []

    
    @IBOutlet weak var favouriteCollectionView: UICollectionView!
    
    
    @IBOutlet weak var btnFavouriteDetails: UIButton!
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setDelegates()
        self.favouriteCollectionView.register(UINib(nibName: "FavouriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteCollectionViewCell")
        let db = FavouriteProductDao()
        favourite_product = db.getAll(limit: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDelegates() {
        self.favouriteCollectionView.delegate = self
        self.favouriteCollectionView.dataSource = self
    }
    
    func refreshFavouriteProductsList(favouriteproductList: [FavouriteProducts]) {
        self.favourite_product = favouriteproductList
        self.favouriteCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourite_product.count
    }
    
    
    @IBAction func favouriteViewAll(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favouritecell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell

        favouritecell.category_name.text = favourite_product[indexPath.row].categoryName
        favouritecell.brand_name.text = favourite_product[indexPath.row].brandName
        let defaultLink = ""
        let completeLink1 = defaultLink + favourite_product[indexPath.row].brandLogoUrl
        favouritecell.brand_logo.DownloadedFrom(link: completeLink1)
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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 20, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

extension UIColor {
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0,0,0,0)
    }
    // hue, saturation, brightness and alpha components from UIColor**
    var hsbComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
            return (hue,saturation,brightness,alpha)
        }
        return (0,0,0,0)
    }
    var htmlRGBColor:String {
        return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
    }
    var htmlRGBaColor:String {
        return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255),Int(rgbComponents.alpha * 255) )
    }
}
