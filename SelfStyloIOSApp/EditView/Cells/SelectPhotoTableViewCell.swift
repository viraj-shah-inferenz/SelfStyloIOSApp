//
//  SelectPhotoTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 30/12/22.
//

import UIKit

class SelectPhotoTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var edtProfile: UIButton!
    @IBOutlet weak var AddProfile: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCircleView(toView: circleView)
        setProfileImageView(toView: profileImageView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   
    func setProfileImageView(toView: UIImageView)
    {
        toView.layer.cornerRadius = (toView.frame.size.width) / 2;
        toView.clipsToBounds = true
    }
    
    func setCircleView(toView: UIView)
    {
        toView.layer.cornerRadius = 20
    }
    
}
