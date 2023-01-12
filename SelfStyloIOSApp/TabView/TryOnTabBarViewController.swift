//
//  TryOnTabBarViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 10/01/23.
//

import UIKit

class TryOnTabBarViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupMiddleButton()
        // Do any additional setup after loading the view.
    }
    

    func setDelegates() {
        self.delegate = self
    }
    
    func setupMiddleButton() {
           let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
           var menuButtonFrame = menuButton.frame
           menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 10
           menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
           menuButton.frame = menuButtonFrame
        
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
           view.addSubview(menuButton)

           menuButton.setImage(UIImage(named: "home_screen_button_logo_app"), for: .normal)
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

           view.layoutIfNeeded()
       }
    
    @objc private func menuButtonAction(sender: UIButton) {
        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DialogSelectionViewController")
            if let sheet = detailViewController.sheetPresentationController {
                sheet.detents = [.medium(), .large()]

            }
        self.present(detailViewController, animated: true, completion: nil)
       }

}
