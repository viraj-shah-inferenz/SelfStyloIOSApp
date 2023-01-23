//
//  MakeupViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 19/01/23.
//

import UIKit

class MakeupViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var eyelinerCV:UIView!
    @IBOutlet weak var lipstickCV: UIView!
    @IBOutlet weak var blushCV: UIView!
    
    @IBOutlet weak var eyeshadowCV: UIView!
    
    @IBOutlet weak var foundationCV: UIView!
    
  
    @IBOutlet weak var makeupView: UIView!
    
    
    var category_image = [UIImage(named: "eyeliner"),UIImage(named: "lipstick"),UIImage(named: "blush"),UIImage(named: "eyeshadow"),UIImage(named: "foundation")]
    var category_name:[String] = ["Eyeliner","Lipstick","Blush","Eyeshadow","Foundation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        // Do any additional setup after loading the view.
        self.categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
    
    
    
    func setDelegates()
    {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category_name.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let categorycell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell

           categorycell.categoryName.text = category_name[indexPath.row]
           categorycell.categoryImage.image = category_image[indexPath.row]
           categorycell.contentView.layer.cornerRadius = 10
           return categorycell
    }
    
    
    var ProductListViewController: LipstickViewController {
        let st = UIStoryboard(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "ProductListViewController") as! LipstickViewController
        return vc
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0{
            eyelinerCV.isHidden = false
            makeupView.alpha = 0
        }
        
        else if indexPath.item == 1{
            lipstickCV.isHidden = false
            makeupView.alpha = 0
        }
        else if indexPath.item == 2{
            blushCV.isHidden = false
            makeupView.alpha = 0
        }else if indexPath.item == 3{
            eyeshadowCV.isHidden = false
            makeupView.alpha = 0
        }else if indexPath.item == 4{
            foundationCV.isHidden = false
            makeupView.alpha = 0
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/3 - 25, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }

}
