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
    
    @IBOutlet weak var termsofUseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCardView(toView: FAQsView)
        setCardView(toView: aboutSelfStyloView)
        setCardView(toView: privacyPolicyView)
        setCardView(toView: termsofUseView)
        aboutSelfStyloView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dialog_about)))
        privacyPolicyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dialog_privacy_policy)))
        FAQsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dialog_faqs)))
        termsofUseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dialog_termsofUse)))
    }
    
    @objc func dialog_about(){
                let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
                detailViewController.modalPresentationStyle = .overCurrentContext
        detailViewController.modalTransitionStyle = .crossDissolve
                self.present(detailViewController, animated: false,completion: nil)
    }
    
    @objc func dialog_privacy_policy(){
                let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
                detailViewController.modalPresentationStyle = .overCurrentContext
        detailViewController.modalTransitionStyle = .crossDissolve
                self.present(detailViewController, animated: true,completion: nil)
    }
    
    @objc func dialog_faqs(){
                let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
                detailViewController.modalPresentationStyle = .overCurrentContext
                detailViewController.modalTransitionStyle = .crossDissolve
                self.present(detailViewController, animated: true,completion: nil)
    }
    
    @objc func dialog_termsofUse(){
                let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "TermsOfUseViewController") as! TermsOfUseViewController
                detailViewController.modalPresentationStyle = .overCurrentContext
                detailViewController.modalTransitionStyle = .crossDissolve
                self.present(detailViewController, animated: true,completion: nil)
    }
    

    func setCardView(toView: UIView)
    {
        toView.layer.cornerRadius = 22
    }
    
    @IBAction func BackHome(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }

}
