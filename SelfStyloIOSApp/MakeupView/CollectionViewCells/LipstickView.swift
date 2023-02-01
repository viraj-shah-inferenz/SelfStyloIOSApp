//
//  LipstickView.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 31/01/23.
//

import UIKit
import WebKit

@IBDesignable
class LipstickView: UIView {

    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    @IBOutlet weak var colorNameCollectionView: UICollectionView!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    
    @IBOutlet weak var btnBack: UIButton!
    
    var color_image:[String] = ["color_code_circle", "color_code_circle","color_code_circle", "color_code_circle","color_code_circle","color_code_circle"]
   
    var color_name:[String] =  ["Pomegranate","RoseWood","RoseWood Gloss","Pomegranate Glitter","Metallic","Bossom"]
    var webView = UIWebView()
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("LipstickView", owner: self,options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        initCollectionView()
       
    }
    
    
    
    private func initCollectionView()
    {
        let nib = UINib(nibName: "ColorCodeCollectionViewCell", bundle: nil)
        productListCollectionView.register(nib, forCellWithReuseIdentifier: "ColorCodeCollectionViewCell")
        productListCollectionView.dataSource = self
        productListCollectionView.delegate = self
        let nib1 = UINib(nibName: "ColorNameCollectionViewCell", bundle: nil)
        colorNameCollectionView.register(nib1, forCellWithReuseIdentifier: "ColorNameCollectionViewCell")
        colorNameCollectionView.dataSource = self
        colorNameCollectionView.delegate = self
    }
    


}

extension LipstickView: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorNameCollectionView{
            return color_name.count
        }
        return 10
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productListCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCodeCollectionViewCell", for: indexPath) as! ColorCodeCollectionViewCell
        //cell.colorImage.image = UIImage(named: color_image[indexPath.row])
        cell.colorImage.backgroundColor = UIColor.blue
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.masksToBounds = false;
        cell.clipsToBounds = true
            if collectionView == colorNameCollectionView{
            let colornamecell = colorNameCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorNameCollectionViewCell", for: indexPath) as! ColorNameCollectionViewCell
            colornamecell.lblcolor_name.text = color_name[indexPath.row]
            return colornamecell
        }
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colorNameCollectionView{
            let bounds = collectionView.bounds
            return CGSize(width: bounds.width/2 - 10, height: bounds.height)
        }
        
        return CGSize(width: bounds.width/7 - 10, height: bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == colorNameCollectionView{
            return 10.0
        }
        
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.item == 1{
//                webView.loadHTMLString("<html><body><p>Hello!</p></body></html>", baseURL: nil)
                let loadURL = "https://www.javatpoint.com"
                       let url = URL(string: loadURL)!
                webView.loadRequest(URLRequest(url: url))
            }
    }
}
