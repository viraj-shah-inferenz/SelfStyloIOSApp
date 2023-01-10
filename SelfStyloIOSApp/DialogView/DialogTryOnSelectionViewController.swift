//
//  DialogTryOnSelectionViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 28/12/22.
//

import UIKit

class DialogTryOnSelectionViewController: UIViewController {

    @IBOutlet weak var cosmeticsCollectionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCardView(toView: cosmeticsCollectionView)
    }
    func setCardView(toView: UIView)
    {
        toView.layer.cornerRadius = 16
        toView.layer.borderColor = UIColor.black.cgColor
        toView.layer.borderWidth = 1
    }

   

}
