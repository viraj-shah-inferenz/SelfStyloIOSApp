//
//  SelectGenderTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 30/12/22.
//

import UIKit

class SelectGenderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblGender: UILabel!
    
    
    @IBOutlet weak var btnMale: UIButton!
    
    @IBOutlet weak var btnOthers: UIButton!
    
    @IBOutlet weak var btnFemale: UIButton!
    
    
    @IBOutlet weak var lblInvalidGender: UILabel!
    var selectedButton = UIButton()
    var gender: String  = ""
    
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
        self.selectedButton.isSelected = false
               self.selectedButton = sender
        self.selectedButton.isSelected = true
               if sender == btnFemale {
                   gender = "Female"
               }
               else  if sender == btnMale {
                   gender = "Male"
               }else if sender == btnOthers{
                   gender = "Others"
               }
    }
    
}
