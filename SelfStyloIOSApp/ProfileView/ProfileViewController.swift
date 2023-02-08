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
    var window: UIWindow?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setProfileImageView(toView: profileImageView)
//        seteditprofilecornerRadiusView(toView: editProfile)
        setbuttoncornerRadiusView(toView: settingsCollectionView)
        setbuttoncornerRadiusView(toView: logoutCollectionView)
        getDataFromDB()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    @IBAction func BackHome(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }
    
    func getDataFromDB() {
        for patron in db.getAll(){
            profileImageView.image = patron.profileImage.imageFromBase64()
            self.userDefault.set(patron.profileImage, forKey: "ProfileImage")
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
        UserDefaults.standard.removeObject(forKey: APP.IS_LOGIN)
        UserDefaults.standard.synchronize()
        
        let loginNavController = self.storyboard!.instantiateViewController(identifier: "SignInViewController")
//        navigationController?.pushViewController(loginNavController, animated: true)
        loginNavController.modalPresentationStyle = .fullScreen
        self.present(loginNavController, animated: false)
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
