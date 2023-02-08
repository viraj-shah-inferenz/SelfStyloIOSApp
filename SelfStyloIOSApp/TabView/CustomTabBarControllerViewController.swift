//
//  CustomTabBarControllerViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 27/12/22.
//

import UIKit

class CustomTabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {

    
    
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
           menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 32
           menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
           menuButton.frame = menuButtonFrame
        
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
           view.addSubview(menuButton)

           menuButton.setImage(UIImage(named: "home_screen_button_logo_app"), for: .normal)
           menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

           view.layoutIfNeeded()
       }
    
    @objc private func menuButtonAction(sender: UIButton) {

//        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DialogSelectionViewController")
//        let smallId = UISheetPresentationController.Detent.Identifier("small")
//        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
//            return 250
//        }
//        if let sheet = detailViewController.sheetPresentationController {
//            sheet.detents = [smallDetent,.medium()]
//           sheet.prefersScrollingExpandsWhenScrolledToEdge = true
//           sheet.prefersEdgeAttachedInCompactHeight = true
//           sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
//        }
//        self.present(detailViewController, animated: true, completion: nil)
        let detailViewController:MakeupLoaderViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MakeupLoaderViewController") as! MakeupLoaderViewController
//        detailViewController.strOpenView = "firstTime"

        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
       }


}
