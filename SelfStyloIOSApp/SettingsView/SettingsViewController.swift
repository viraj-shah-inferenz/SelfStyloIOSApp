//
//  SettingsViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var FAQsView: UIView!
    
    @IBOutlet weak var aboutSelfStyloView: UIView!
    
    @IBOutlet weak var privacyPolicyView: UIView!
    
    @IBOutlet weak var termsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCardView(toView: FAQsView)
        setCardView(toView: aboutSelfStyloView)
        setCardView(toView: privacyPolicyView)
        setCardView(toView: termsView)
    }
    

    func setCardView(toView: UIView)
    {
        toView.layer.cornerRadius = 22
    }

}
