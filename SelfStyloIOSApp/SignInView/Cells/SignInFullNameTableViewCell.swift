//
//  SignInFullNameTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 06/01/23.
//

import UIKit

class SignInFullNameTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var txtFullName: UITextField!
    
    let validityType: String.ValidityType = .name
    
    @IBOutlet weak var lblInvalidName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        settxtFullNameView(toView: txtFullName)
        txtFullName.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: txtFullName.frame.height))
        txtFullName.leftViewMode = .always
        txtFullName.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        
        txtFullName.delegate = self
    
    }
    
    @objc fileprivate func handleTextChange(){
        guard let name = txtFullName.text else { return }
        if name.isValid(validityType) {
            lblInvalidName.text = " "
        }else
        {
            lblInvalidName.text = "Not a Valid \(validityType)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func settxtFullNameView(toView: UITextField)
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
        let maxLength = 10
           let currentString: NSString = textField.text! as NSString
           let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
           return newString.length <= maxLength
    }
    
}
