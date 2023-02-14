//
//  AboutViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 13/02/23.
//

import UIKit

enum UIBlurEffectStyle : Int {
    case ExtraLight
    case Light
    case Dark
}

class AboutViewController: UIViewController {

    lazy var blurredView: UIView = {
            // 1. create container view
            let containerView = UIView()
            // 2. create custom blur view
            let blurEffect = UIBlurEffect(style: .light)
            let customBlurEffectView = CustomVisualEffectView(effect: blurEffect, intensity: 0.1)
            customBlurEffectView.frame = self.view.bounds
            // 3. create semi-transparent black view
            let dimmedView = UIView()
            dimmedView.backgroundColor = .gray.withAlphaComponent(0.6)
            dimmedView.frame = self.view.bounds
            
            // 4. add both as subviews
            containerView.addSubview(customBlurEffectView)
            containerView.addSubview(dimmedView)
            return containerView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    func setupView() {
           // 6. add blur view and send it to back
           view.addSubview(blurredView)
           view.sendSubviewToBack(blurredView)
       }

    @IBAction func btn_dismiss(_ sender: UIButton) {
        self.dismiss(animated: false,completion: nil)
        
    }
    
}
