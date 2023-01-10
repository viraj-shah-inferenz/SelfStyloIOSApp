//
//  FavouriteViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 27/12/22.
//

import UIKit


class FavouriteViewController: UIViewController {

    @IBOutlet weak var btnHomeView: UIButton!
    @IBOutlet weak var FavouriteCollectionView: UICollectionView!
    var brandlogoArr = [UIImage(named: "brandlogo"),UIImage(named: "brandlogo"),UIImage(named: "brandlogo")]
    var brand_name:[String] = ["Inferenz","Inferenz","Inferenz"]
    var color_code = [UIImage(named: "color_code"),UIImage(named: "color_code"),UIImage(named: "color_code")]
    var color_name:[String] = ["Red Pink","Red Pink","Red Pink"]
    var category_name:[String] = ["Lipstick","Eyeliner","Blush"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnHomeView.addTarget(self, action: #selector(BackHome(sender: )), for: .touchUpInside)
    }
    
    @objc func BackHome(sender: UIButton){
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
}

extension FavouriteViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandlogoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(1) as? UILabel{
            vc.text = category_name[indexPath.row]
        } else if let vc = cell.viewWithTag(2) as? UILabel{
            vc.text = brand_name[indexPath.row]
        } else if let vc = cell.viewWithTag(3) as? UIImageView{
            vc.image = brandlogoArr[indexPath.row]
        } else if let vc = cell.viewWithTag(4) as? UILabel{
            vc.text = color_name[indexPath.row]
        }else if let vc = cell.viewWithTag(5) as? UIImageView{
            vc.image = color_code[indexPath.row]
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
