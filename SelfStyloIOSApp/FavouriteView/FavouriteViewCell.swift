//
//  FavouriteViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 10/02/23.
//

import UIKit

class FavouriteViewCell: UICollectionViewCell {
    @IBOutlet weak var category_logo: UIImageView!
    @IBOutlet weak var category_name: UILabel!
    @IBOutlet weak var brand_logo: UIImageView!
    @IBOutlet weak var brand_name: UILabel!
    @IBOutlet weak var color_name: UILabel!
    @IBOutlet weak var color_code: UIImageView!
    @IBOutlet weak var sub_category_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
