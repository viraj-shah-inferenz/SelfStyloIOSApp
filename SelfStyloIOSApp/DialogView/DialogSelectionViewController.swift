//
//  DialogSelectionViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 29/12/22.
//

import UIKit

class DialogSelectionViewController: UIViewController {
    
    @IBOutlet weak var homeCardBtnSelfiecam: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        homeCardBtnSelfiecam.addGestureRecognizer(tap)
        sethomeCardBtnSelfiecam(toView: homeCardBtnSelfiecam)
       
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer)
    {
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "DialogSelfieCamSelectionViewController") as! DialogSelfieCamSelectionViewController
        let smallId = UISheetPresentationController.Detent.Identifier("small")
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
            return 250
        }
        if let sheet = detailViewController.sheetPresentationController {
            sheet.detents = [smallDetent,.medium()]
            sheet.largestUndimmedDetentIdentifier = .medium
           sheet.prefersScrollingExpandsWhenScrolledToEdge = false
           sheet.prefersEdgeAttachedInCompactHeight = true
           sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        self.present(detailViewController, animated: true,completion: nil)
    }
    
    func sethomeCardBtnSelfiecam(toView: UIView)
    {
        toView.layer.cornerRadius = 16
        toView.layer.backgroundColor = UIColor.white.cgColor
    }

}
