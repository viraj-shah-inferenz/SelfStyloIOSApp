//
//  NotificationViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/02/23.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func BackHome(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }
    
}
