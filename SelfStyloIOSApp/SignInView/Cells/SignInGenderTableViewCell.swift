//
//  SignInGenderTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 06/01/23.
//

import UIKit

class SignInGenderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblGender: UILabel!
    
    
    @IBOutlet weak var btnMale: UIButton!
    
    @IBOutlet weak var lblMale: UILabel!
    
    @IBOutlet weak var lblOthers: UILabel!
    
    @IBOutlet weak var btnOthers: UIButton!
    
    @IBOutlet weak var btnFemale: UIButton!
    
    @IBOutlet weak var lblFemale: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        btnMale.setImage(UIImage.init(named: "radiobutton_unchecked"), for: .normal)
        btnMale.setImage(UIImage.init(named: "radiobutton_checked"), for: .selected)
        
        btnFemale.setImage(UIImage.init(named: "radiobutton_unchecked"), for: .normal)
        btnFemale.setImage(UIImage.init(named: "radiobutton_checked"), for: .selected)
        
        btnOthers.setImage(UIImage.init(named: "radiobutton_unchecked"), for: .normal)
        btnOthers.setImage(UIImage.init(named: "radiobutton_checked"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnSelectGender(_ sender: UIButton) {
        if sender == btnFemale{
            btnFemale.isSelected = true
        }else
        {
            btnFemale.isSelected = false
        }
        
        if sender == btnMale{
            btnMale.isSelected = true
        }else
        {
            btnMale.isSelected = false
        }
        
        if sender == btnOthers{
            btnOthers.isSelected = true
        }else
        {
            btnOthers.isSelected = false
        }
    }
    
}
