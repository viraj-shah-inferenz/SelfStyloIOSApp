//
//  SignInPhoneTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 06/01/23.
//

import UIKit
import FlagPhoneNumber

class SignInPhoneTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var txtPhoneNumber: FPNTextField!
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblInvalidPhone: UILabel!
    let validityType: String.ValidityType = .phone

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txtPhoneNumber.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        txtPhoneNumber.displayMode = .picker
        txtPhoneNumber.delegate = self
        
                let items = [
               UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: nil),
               UIBarButtonItem(title: "Item 1", style: .plain, target: self, action: nil),
               UIBarButtonItem(title: "Item 2", style: .plain, target: self, action: nil)
           ]
               txtPhoneNumber.textFieldInputAccessoryView = getCustomTextFieldInputAccessoryView(with: items)
               txtPhoneNumber.placeholder = "Phone Number"
               txtPhoneNumber.setFlag(countryCode: .IN)
        settxtPhoneView(toView: txtPhoneNumber)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let patron = Patron()
        patron.phoneNumber = txtPhoneNumber.text!
        print(patron.phoneNumber)
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
        if phone.isValid(validityType) {
            lblInvalidPhone.text = " "
        }else
        {
            lblInvalidPhone.text = "Not a Valid \(validityType)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func settxtPhoneView(toView: UITextField)
    {
        toView.layer.cornerRadius = 18
        toView.layer.borderWidth = 1
        toView.backgroundColor = UIColor.white
        toView.layer.borderColor =  UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7).cgColor
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
                   let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
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


extension SignInPhoneTableViewCell: FPNTextFieldDelegate {

    func fpnDisplayCountryList() {
    }

    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
    }

    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        //print(name, dialCode, code)
        txtPhoneNumber.text = dialCode
    }

}
