//
//  SignInViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit

class SignInViewController: UIViewController {

    
   
    @IBOutlet weak var EmailIdView: UIView!
    
    @IBOutlet weak var PhoneView: UIView!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    @IBOutlet weak var btnProceed: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            EmailIdView.alpha = 1
            PhoneView.alpha = 0
        }else
        {
            PhoneView.alpha = 1
            EmailIdView.alpha = 0
        }
    }
    
    
    @IBAction func btnProceed(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func btnSelectCheckbox(_ sender: UIButton) {
        if btnCheckbox.isSelected && btnProceed?.isEnabled == true{
            btnCheckbox.setImage(UIImage.init(named: "unchecked"), for: .normal)
            btnProceed?.isEnabled = false
        }else
        {
            btnCheckbox.setImage(UIImage.init(named: "checked"), for: .normal)
            btnProceed?.isEnabled = true
        }
        btnCheckbox.isSelected = !btnCheckbox.isSelected
    }
    
}
