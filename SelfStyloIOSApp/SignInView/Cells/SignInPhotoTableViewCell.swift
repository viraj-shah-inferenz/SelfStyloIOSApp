//
//  SignInPhotoTableViewCell.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 06/01/23.
//

import UIKit

class SignInPhotoTableViewCell: UITableViewCell,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var AddProfile: UILabel!
    
    @IBOutlet weak var edtProfile: UIButton!
    
    var patron = Patron()
    let db = PatronDao()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setProfileImageView(toView: profileImageView)
        setCircleView(toView: circleView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        if let img = profileImageView.image {
//            guard let base64img = img.base64(format: .jpeg(1.0)) else { return }
//            patron.profileImage = base64img
//        }
//        profileImageView.image = patron.profileImage.imageFromBase64()
//        db.insert(userList: patron)
//        self.parentContainerViewController?.dismiss(animated: true, completion: nil)
//    }
    
   
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
