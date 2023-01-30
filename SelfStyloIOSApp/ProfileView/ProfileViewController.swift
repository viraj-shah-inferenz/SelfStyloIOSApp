//
//  ProfileViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 29/12/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var editProfile: UIView!
    @IBOutlet weak var circleImageView: UIView!
    
    @IBOutlet weak var settingsCollectionView: UIView!
    
    @IBOutlet weak var logoutCollectionView: UIView!
    
    
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
        setcornerRadiusView(toView: circleImageView)
        seteditprofilecornerRadiusView(toView: editProfile)
        setbuttoncornerRadiusView(toView: settingsCollectionView)
        setbuttoncornerRadiusView(toView: logoutCollectionView)
        getDataFromDB()
    }
    
    
    
    func getDataFromDB() {
        for patron in db.getAll(){
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
    
    func setcornerRadiusView(toView: UIView)
    {
        toView.layer.cornerRadius = 120 / 2
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
