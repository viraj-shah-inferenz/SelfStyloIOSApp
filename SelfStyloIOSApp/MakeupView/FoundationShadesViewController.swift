//
//  FoundationShadesViewController.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 03/03/23.
//

import UIKit

class FoundationShadesViewController: UIViewController {

    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    
    
    @IBOutlet weak var btnUndertone1: UIButton!
    @IBOutlet weak var btnUndertone2: UIButton!
    @IBOutlet weak var btnUndertone3: UIButton!
    
    @IBOutlet weak var btnSkintone1: UIButton!
    @IBOutlet weak var btnSkintone2: UIButton!
    @IBOutlet weak var btnSkintone3: UIButton!
    @IBOutlet weak var btnSkintone4: UIButton!
    @IBOutlet weak var btnSkintone5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.layer.cornerRadius = 12
        btnNext.clipsToBounds = false
    }

    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func undertoneShadeAction(_ sender: UIButton) {
        print("undertones \(sender.tag)")
        
        btnUndertone1.layer.borderWidth = 0.0
        btnUndertone1.layer.borderColor = UIColor.clear.cgColor
        
        btnUndertone2.layer.borderWidth = 0.0
        btnUndertone2.layer.borderColor = UIColor.clear.cgColor
        
        btnUndertone3.layer.borderWidth = 0.0
        btnUndertone3.layer.borderColor = UIColor.clear.cgColor
        
        switch sender.tag {
        case 1:
            btnUndertone1.layer.borderWidth = 1.0
            btnUndertone1.layer.borderColor = UIColor.white.cgColor
            break
        case 2:
            btnUndertone2.layer.borderWidth = 1.0
            btnUndertone2.layer.borderColor = UIColor.white.cgColor
            break
        case 3:
            btnUndertone3.layer.borderWidth = 1.0
            btnUndertone3.layer.borderColor = UIColor.white.cgColor
            break
        default:
            break
            
        }
    }
    
    
    @IBAction func skintoneShadeAction(_ sender: UIButton) {
        print("skintones \(sender.tag)")
        
        btnSkintone1.layer.borderWidth = 0.0
        btnSkintone1.layer.borderColor = UIColor.clear.cgColor
        
        btnSkintone2.layer.borderWidth = 0.0
        btnSkintone2.layer.borderColor = UIColor.clear.cgColor
        
        btnSkintone3.layer.borderWidth = 0.0
        btnSkintone3.layer.borderColor = UIColor.clear.cgColor
        
        btnSkintone4.layer.borderWidth = 0.0
        btnSkintone4.layer.borderColor = UIColor.clear.cgColor
        
        btnSkintone5.layer.borderWidth = 0.0
        btnSkintone5.layer.borderColor = UIColor.clear.cgColor
        
        switch sender.tag {
        case 1:
            btnSkintone1.layer.borderWidth = 1.0
            btnSkintone1.layer.borderColor = UIColor.white.cgColor
            break
        case 2:
            btnSkintone2.layer.borderWidth = 1.0
            btnSkintone2.layer.borderColor = UIColor.white.cgColor
            break
        case 3:
            btnSkintone3.layer.borderWidth = 1.0
            btnSkintone3.layer.borderColor = UIColor.white.cgColor
            break
        case 4:
            btnSkintone4.layer.borderWidth = 1.0
            btnSkintone4.layer.borderColor = UIColor.white.cgColor
            break
        case 5:
            btnSkintone5.layer.borderWidth = 1.0
            btnSkintone5.layer.borderColor = UIColor.white.cgColor
            break
        default:
            break
            
        }
    }
    
    
}
