//
//  FoundationAnalyzeViewController.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 03/03/23.
//

import UIKit

class FoundationAnalyzeViewController: UIViewController {

    @IBOutlet weak var imgPositive: UIImageView!
    @IBOutlet weak var imgNagetive: UIImageView!
    
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var nagetiveLayerView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    fileprivate func setupView() {
        imgPositive.image = UIImage(named: "maria_pic")
        imgNagetive.image = UIImage(named: "maria_pic")
        
        imgPositive.layer.cornerRadius = 14
        imgPositive.clipsToBounds = true
        
        imgNagetive.layer.cornerRadius = 14
        imgNagetive.clipsToBounds = true
        
        nagetiveLayerView.layer.cornerRadius = 14
        nagetiveLayerView.clipsToBounds = true
        
        btnNext.layer.cornerRadius = 12
        btnNext.clipsToBounds = true
        
        greenView.layer.cornerRadius = greenView.bounds.width / 2
        greenView.clipsToBounds = true
        
        redView.layer.cornerRadius = redView.bounds.width / 2
        redView.clipsToBounds = true
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
