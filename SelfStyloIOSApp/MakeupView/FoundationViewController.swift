//
//  FoundationViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 23/01/23.
//

import UIKit

class FoundationViewController: UIViewController {

    var backToCategory : (()-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func btnBack(_ sender: UIButton) {
        backToCategory?()
//        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "MakeupViewController") as! MakeupViewController
//        detailViewController.modalPresentationStyle = .fullScreen
//        self.present(detailViewController, animated: false)
    }
   

}
