//
//  TryOnViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 31/01/23.
//

import UIKit
import WebKit

class TryOnViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var makeupView: UIView!
    
    
    @IBOutlet weak var lipstickView: LipstickView!
    
    @IBOutlet weak var comboView: CardView!
    
    
    @IBOutlet weak var webView: UIWebView!
    
    var category_image = [UIImage(named: "eyeliner"),UIImage(named: "lipstick"),UIImage(named: "blush"),UIImage(named: "eyeshadow"),UIImage(named: "foundation")]
    var category_name:[String] = ["Eyeliner","Lipstick","Blush","Eyeshadow","Foundation"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
      
        self.categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
       
        comboView.target(forAction: #selector(combo), withSender: nil)
        comboView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(combo)))
        lipstickView.btnCheckbox.addTarget(self, action: #selector(btnSelectCheckbox), for: .touchUpInside)
        lipstickView.btnBack.addTarget(self, action: #selector(btnBack), for: .touchUpInside)
        lipstickView.webView = webView
        
        
    }
    
    @objc func combo(){
       
    }
    
    @objc func btnSelectCheckbox() {
        if lipstickView.btnCheckbox.isSelected{
            lipstickView.btnCheckbox.setImage(UIImage.init(named: "favourite_unchecked"), for: .normal)
        }else
        {
            lipstickView.btnCheckbox.setImage(UIImage.init(named: "favourite_checked"), for: .normal)
        }
        lipstickView.btnCheckbox.isSelected = !lipstickView.btnCheckbox.isSelected
    }
    
    

    func setDelegates()
    {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    @IBAction func backHome(_ sender: UIButton) {
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
    @objc func btnBack() {
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "TryOnViewController") as! TryOnViewController
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 1{
            lipstickView.alpha = 1
            makeupView.alpha = 0
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 25, height: bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }

}

