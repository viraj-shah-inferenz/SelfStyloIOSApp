//
//  MakeupLayerTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 17/02/23.
//

import UIKit

class MakeupLayerTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: CardView!
    @IBOutlet weak var imgMakeupImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var makeupName: UILabel!
    @IBOutlet weak var removeItemButton: UIButton!
    @IBOutlet weak var imgColorCode: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
