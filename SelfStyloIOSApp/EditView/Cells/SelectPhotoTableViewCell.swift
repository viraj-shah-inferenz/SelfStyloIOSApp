//
//  SelectPhotoTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 30/12/22.
//

import UIKit

class SelectPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var DashBorderLine: UIImageView!
    
    @IBOutlet weak var AddProfile: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
