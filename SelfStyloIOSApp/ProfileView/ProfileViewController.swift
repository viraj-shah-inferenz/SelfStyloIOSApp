//
//  ProfileViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 29/12/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var editProfile: UIView!
    
    @IBOutlet weak var settingsCollectionView: UIView!
    
    @IBOutlet weak var logoutCollectionView: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblGender: UILabel!
    
    let db = PatronDao()
    let userDefault = UserDefaults.standard
    var apiUtils = ApiUtils()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setProfileImageView(toView: profileImageView)
        seteditprofilecornerRadiusView(toView: editProfile)
        setbuttoncornerRadiusView(toView: settingsCollectionView)
        setbuttoncornerRadiusView(toView: logoutCollectionView)
        getDataFromDB()
    }
    
    
    @IBAction func BackHome(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }
    
    func getDataFromDB() {
        for patron in db.getAll(){
            profileImageView.image = patron.profileImage.imageFromBase64()
            lblName.text = patron.name
            self.userDefault.set(patron.name, forKey: "Name")
            lblEmail.text = patron.email
            self.userDefault.set(patron.email, forKey: "Email")
            lblPhone.text = patron.phoneNumber
            self.userDefault.set(patron.phoneNumber, forKey: "Phone")
            lblGender.text = patron.gender
        }
    }
    
    
    @IBAction func btnlogout(_ sender: UIButton) {
        db.deleteAll()
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
    func setProfileImageView(toView: UIImageView)
    {
        toView.layer.cornerRadius = (toView.frame.size.width) / 2;
        toView.clipsToBounds = true
    }
    
    func seteditprofilecornerRadiusView(toView: UIView)
    {
        toView.layer.cornerRadius = 20
    }
    
    func setbuttoncornerRadiusView(toView: UIView)
    {
        toView.layer.cornerRadius = 22
    }

}
