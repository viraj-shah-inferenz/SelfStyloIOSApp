//
//  FavouriteProductTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import UIKit

class FavouriteProductTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var brandlogoArr = [UIImage(named: "brandlogo"),UIImage(named: "brandlogo"),UIImage(named: "brandlogo")]
    var brand_name:[String] = ["Inferenz","Inferenz","Inferenz"]
    var color_code = [UIImage(named: "color_code"),UIImage(named: "color_code"),UIImage(named: "color_code")]
    var color_name:[String] = ["Red Pink","Red Pink","Red Pink"]
    var category_name:[String] = ["Lipstick","Eyeliner","Blush"]
    
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDelegates() {
        self.favouriteCollectionView.delegate = self
        self.favouriteCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
    @IBAction func favouriteViewAll(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favouritecell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionViewCell", for: indexPath) as! FavouriteCollectionViewCell

           favouritecell.category_name.text = self.category_name[indexPath.row]
           favouritecell.brand_name.text = self.brand_name[indexPath.row]
           favouritecell.brand_logo.image = self.brandlogoArr[indexPath.row]
           favouritecell.color_name.text = self.color_name[indexPath.row]
           favouritecell.color_code.image = self.color_code[indexPath.row]

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
    
}
