//
//  CustomTabBarControllerViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 27/12/22.
//

import UIKit

class CustomTabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupMiddleButton()
    }
    
    func setDelegates() {
        self.delegate = self
    }
    
    func setupMiddleButton() {
           let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
           var menuButtonFrame = menuButton.frame
           menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 40
           menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
           menuButton.frame = menuButtonFrame
        
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
           view.addSubview(menuButton)

           menuButton.setImage(UIImage(named: "home_screen_button_logo_app"), for: .normal)
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

           view.layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        
        
        let detailViewController:MakeupLoaderViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MakeupLoaderViewController") as! MakeupLoaderViewController
        detailViewController.modalPresentationStyle = .fullScreen
        detailViewController.delegate = self
        
        self.navigationController?.present(detailViewController, animated: true)
    }
    

}

extension CustomTabBarControllerViewController: MakeupLoaderDelegate {
    func didLoadMakeup(vc: UIViewController) {
        vc.dismiss(animated: true)
        
        let makeupVC = self.storyboard?.instantiateViewController(withIdentifier: "MakeupViewController") as! MakeupViewController
        makeupVC.modalPresentationStyle = .fullScreen
        self.present(makeupVC, animated: true)
    }
    
    
}
