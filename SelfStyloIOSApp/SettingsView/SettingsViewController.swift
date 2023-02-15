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
        setupCardView()
        setupTap()
    }
    
    func setupCardView(){
        setCardView(toView: FAQsView)
        setCardView(toView: aboutSelfStyloView)
        setCardView(toView: privacyPolicyView)
        setCardView(toView: termsofUseView)
    }
    
    func setupTap() {
          let abouttouchDown = UILongPressGestureRecognizer(target:self, action: #selector(dialog_about))
          abouttouchDown.minimumPressDuration = 0
          aboutSelfStyloView.addGestureRecognizer(abouttouchDown)
          let privacyPolicytouchDown = UILongPressGestureRecognizer(target:self, action: #selector(dialog_privacy_policy))
           privacyPolicytouchDown.minimumPressDuration = 0
          privacyPolicyView.addGestureRecognizer(privacyPolicytouchDown)
        let FAQstouchDown = UILongPressGestureRecognizer(target:self, action: #selector(dialog_faqs))
         FAQstouchDown.minimumPressDuration = 0
        FAQsView.addGestureRecognizer(FAQstouchDown)
        let termsofUsetouchDown = UILongPressGestureRecognizer(target:self, action: #selector(dialog_termsofUse))
        termsofUsetouchDown.minimumPressDuration = 0
        termsofUseView.addGestureRecognizer(termsofUsetouchDown)
      }

    
    
    @objc func dialog_about(gesture: UILongPressGestureRecognizer){
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        detailViewController.modalPresentationStyle = .overCurrentContext
detailViewController.modalTransitionStyle = .crossDissolve
        self.present(detailViewController, animated: false,completion: nil)
        if gesture.state == .began {
            aboutSelfStyloView.backgroundColor = UIColorFromHex(rgbValue: 0x0D0F17,alpha: 0.1)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            aboutSelfStyloView.backgroundColor = .systemBackground
        }
    }
    
    
    
    @objc func dialog_privacy_policy(gesture: UILongPressGestureRecognizer){
                let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
                detailViewController.modalPresentationStyle = .overCurrentContext
        detailViewController.modalTransitionStyle = .crossDissolve
                self.present(detailViewController, animated: true,completion: nil)
        if gesture.state == .began {
            privacyPolicyView.backgroundColor = UIColorFromHex(rgbValue: 0x0D0F17,alpha: 0.1)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            privacyPolicyView.backgroundColor = .systemBackground
        }
    }
    
    @objc func dialog_faqs(gesture: UILongPressGestureRecognizer){
                let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
                detailViewController.modalPresentationStyle = .overCurrentContext
                detailViewController.modalTransitionStyle = .crossDissolve
                self.present(detailViewController, animated: true,completion: nil)
        if gesture.state == .began {
            FAQsView.backgroundColor = UIColorFromHex(rgbValue: 0x0D0F17,alpha: 0.1)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            FAQsView.backgroundColor = .systemBackground
        }
    }
    
    @objc func dialog_termsofUse(gesture: UILongPressGestureRecognizer){
                let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "TermsOfUseViewController") as! TermsOfUseViewController
                detailViewController.modalPresentationStyle = .overCurrentContext
                detailViewController.modalTransitionStyle = .crossDissolve
                self.present(detailViewController, animated: true,completion: nil)
        if gesture.state == .began {
            termsofUseView.backgroundColor = UIColorFromHex(rgbValue: 0x0D0F17,alpha: 0.1)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            termsofUseView.backgroundColor = .systemBackground
        }
    }
    

    func setCardView(toView: UIView)
    {
        toView.layer.cornerRadius = 22
    }
    
    @IBAction func BackHome(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }

    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
