//
//  SelectEmailTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 30/12/22.
//

import UIKit

class SelectEmailTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var lblInvalidEmail: UILabel!
    
    let validityType: String.ValidityType = .email
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        settxtEmailView(toView: txtEmailAddress)
        txtEmailAddress.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: txtEmailAddress.frame.height))
        txtEmailAddress.leftViewMode = .always
        txtEmailAddress.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func settxtEmailView(toView: UITextField)
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
    
}
