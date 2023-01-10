//
//  HomeCardSelfiecamTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import UIKit

class HomeCardSelfiecamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var homeCardBtnSelfiecam: UIView!
    
    var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sethomeCardBtnTryonView(toView: homeCardBtnSelfiecam)
    
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func sethomeCardBtnTryonView(toView: UIView)
    {
        toView.layer.cornerRadius = 16
        toView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    
}
