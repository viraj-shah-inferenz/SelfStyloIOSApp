//
//  SelectPhoneTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 30/12/22.
//

import UIKit

class SelectPhoneTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblInvalidPhone: UILabel!
    let validityType: String.ValidityType = .phone
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        settxtPhoneView(toView: txtPhoneNumber)
        txtPhoneNumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: txtPhoneNumber.frame.height))
        txtPhoneNumber.leftViewMode = .always
        txtPhoneNumber.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        txtPhoneNumber.delegate = self
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
                       let maxLength = 10
                       let currentString: NSString = textField.text! as NSString
                       let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                       is_check = newString.length <= maxLength
                   }
                   return is_check
               }else {
                  return true
               }
           }
    
}
