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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setcornerRadiusView(toView: circleImageView)
        seteditprofilecornerRadiusView(toView: editProfile)
        setbuttoncornerRadiusView(toView: settingsCollectionView)
        setbuttoncornerRadiusView(toView: logoutCollectionView)
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
