//
//  SignInPhoneViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit
import FlagPhoneNumber

class SignInPhoneViewController: UIViewController,UITextFieldDelegate  {
    
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblInvalidPhone: UILabel!
    let validityType: String.ValidityType = .phone
    
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .plain)
    var repository: FPNCountryRepository = FPNCountryRepository()
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPhoneNumber.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        phoneNumberTextField.displayMode = .list
        phoneNumberTextField.delegate = self
        txtPhoneNumber.delegate = self
        
        listController.setup(repository: phoneNumberTextField.countryRepository)
        
        listController.didSelect = { [weak self] country in
            self?.phoneNumberTextField.setFlag(countryCode: country.code)
        }
        phoneNumberTextField.font = UIFont.systemFont(ofSize: 14)
        
        // Custom the size/edgeInsets of the flag button
        phoneNumberTextField.flagButtonSize = CGSize(width: 35, height: 35)
        phoneNumberTextField.flagButton.largeContentImageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: nil),
            UIBarButtonItem(title: "Item 1", style: .plain, target: self, action: nil),
            UIBarButtonItem(title: "Item 2", style: .plain, target: self, action: nil)
        ]
        phoneNumberTextField.textFieldInputAccessoryView = getCustomTextFieldInputAccessoryView(with: items)
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.setFlag(countryCode: .IN)
        setTextFieldView(toView: phoneNumberTextField)
        
    }
    
    private func getCustomTextFieldInputAccessoryView(with items: [UIBarButtonItem]) -> UIToolbar {
        let toolbar: UIToolbar = UIToolbar()
        
        toolbar.barStyle = UIBarStyle.default
        toolbar.items = items
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    @objc fileprivate func handleTextChange(){
        guard let phone = txtPhoneNumber.text else { return }
        if phone.isValid(validityType){
            lblInvalidPhone.text = " "
        }else
        {
            lblInvalidPhone.text = "Not a Valid \(validityType)"
        }
    }
    
    func setTextFieldView(toView: UIView){
        toView.layer.cornerRadius = 18
        toView.layer.borderWidth = 1
        toView.layer.backgroundColor = UIColor.white.cgColor
        toView.layer.borderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7).cgColor
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPhoneNumber {
            var is_check : Bool
            let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            is_check = string == numberFiltered
            
            if is_check {
                let maxLength = 11
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                is_check = newString.length <= maxLength
            }
            return is_check
            
        }else {
            return true
        }
        
    }
    
    
    @objc func dismissCountries() {
        listController.dismiss(animated: true, completion: nil)
    }
}


extension SignInPhoneViewController: FPNTextFieldDelegate {
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))
        
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        textField.rightViewMode = .always
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
       // print(name, dialCode, code)
    }
    
}



