//
//  SignInEmailViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit

class SignInEmailViewController: UIViewController{
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var lblInvalidEmail: UILabel!
    
    let validityType: String.ValidityType = .email
    
    @IBOutlet weak var btnCheckbox: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmailAddress.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: txtEmailAddress.frame.height))
        txtEmailAddress.leftViewMode = .always
        txtEmailAddress.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        
        // Do any additional setup after loading the view.
    }
    
    


    @objc fileprivate func handleTextChange(){
        guard let email = txtEmailAddress.text else { return }
        if email.isValid(validityType) {
            lblInvalidEmail.text = " "
        }else
        {
            lblInvalidEmail.text = "Not a Valid \(validityType)"
        }
    }
    
    @IBAction func btnSelectCheckbox(_ sender: UIButton) {
        if btnCheckbox.isSelected{
            btnCheckbox.setImage(UIImage.init(named: "unchecked"), for: .normal)
        }else
        {
            btnCheckbox.setImage(UIImage.init(named: "checked"), for: .normal)
        }
        btnCheckbox.isSelected = !btnCheckbox.isSelected
    }



}
