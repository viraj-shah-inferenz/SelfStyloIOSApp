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
    
    var apiCalls = IApiCalls()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnNext.layer.cornerRadius = 12
        btnNext.clipsToBounds = false
        
        btnNext.addTarget(self, action: #selector(nextAction(sender: )), for: .touchUpInside)
        
    }
    
    @objc func nextAction(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /*func getUndertoneSkintone() {
        let appUtils =  ApiUtils()
        
        let serviceUrl = ApiUtils.MAKEUP_URL + apiCalls.get_undertone_skintone
        
        appUtils.getUndertoneSkintone(fronUrl: serviceUrl) { Result in
            switch Result {
            case .success(let data):
                do {
                    let skintoneUndertone = try JSONDecoder().decode(SkintoneUndertone.self, from: data)
                    print("skintones: \(skintoneUndertone.data?.skintones)")
                    if let skintone = skintoneUndertone.data?.skintones {
                        
                        for i in 0..<skintone.count {
                            if i == 0 {
                                let skinData = skintone[i]
                                self.btnSkintone1.backgroundColor = skinData.code?.rgbToColor()
                            } else if i == 1 {
                                let skinData = skintone[i]
                                self.btnSkintone2.backgroundColor = skinData.code?.rgbToColor()
                            } else if i == 2 {
                                let skinData = skintone[i]
                                self.btnSkintone3.backgroundColor = skinData.code?.rgbToColor()
                            } else if i == 3 {
                                let skinData = skintone[i]
                                self.btnSkintone4.backgroundColor = skinData.code?.rgbToColor()
                            } else if i == 4 {
                                let skinData = skintone[i]
                                self.btnSkintone5.backgroundColor = skinData.code?.rgbToColor()
                            }
                        }
                    }
                    
                    if let undertone = skintoneUndertone.data?.undertones {
                        for i in 0..<undertone.count {
                            if i == 0 {
                                let skinData = undertone[i]
                                self.btnUndertone1.backgroundColor = skinData.code?.rgbToColor()
                            } else if i == 1 {
                                let skinData = undertone[i]
                                self.btnUndertone2.backgroundColor = skinData.code?.rgbToColor()
                            } else if i == 2 {
                                let skinData = undertone[i]
                                self.btnUndertone3.backgroundColor = skinData.code?.rgbToColor()
                            }
                        }
                    }
                } catch let err {
                    print(err.localizedDescription)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        
    }*/
    
    
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
