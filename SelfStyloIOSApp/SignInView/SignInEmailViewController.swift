//
//  SignInEmailViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit

class SignInEmailViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var lblInvalidEmail: UILabel!
    
    let validityType: String.ValidityType = .email
    
    
    
    var vc: SignInViewController!
    
    var apiUtils = ApiUtils()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        txtEmailAddress.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: (txtEmailAddress.frame.height)))
        txtEmailAddress.leftViewMode = .always
        txtEmailAddress.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        txtEmailAddress.delegate = self
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if let email = txtEmailAddress.text {
                if email != "" {
                        let patron = Patron(email: txtEmailAddress.text!)
                        apiUtils.sendEmailOtp(email: patron.email)


                } else {
                    print("Please enter valid email address")
                }
            }
            
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
    



}
