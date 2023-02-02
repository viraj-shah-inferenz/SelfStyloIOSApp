//
//  SignInEmailViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit

protocol ChildToParentProtocol: AnyObject {
    //Changed value to Int for passing the tag.
    func setFocusedElement(with value: Int)
}

class SignInEmailViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var lblInvalidEmail: UILabel!
    
    let validityType: String.ValidityType = .email
    
    var selectedTFTag = 0
    weak var delegate: ChildToParentProtocol? = nil
    
    var vc: SignInViewController!
    
    var apiUtils = ApiUtils()
    
    let userDefault = UserDefaults.standard
    
    

    var emailText:((String) -> String)?
    var strEmail: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        txtEmailAddress.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: (txtEmailAddress.frame.height)))
        txtEmailAddress.leftViewMode = .always
        txtEmailAddress.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        txtEmailAddress.delegate = self
        
        txtEmailAddress.tag = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//            if let email = txtEmailAddress.text {
//                if email != "" {
//                        let patron = Patron(email: txtEmailAddress.text!)
//                    strEmail = email
//                    let trimmed = patron.email.trimmingCharacters(in: .whitespacesAndNewlines)
//                        apiUtils.sendEmailOtp(email: trimmed)
//                        self.userDefault.set(trimmed, forKey: "Email")
//
//                } else {
//                    strEmail = "Please enter valid email address"
//                    print("Please enter valid email address")
//                }
//            }
        
        selectedTFTag = txtEmailAddress.tag
                //Pass tag to parent view
                delegate?.setFocusedElement(with: selectedTFTag)
            
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
