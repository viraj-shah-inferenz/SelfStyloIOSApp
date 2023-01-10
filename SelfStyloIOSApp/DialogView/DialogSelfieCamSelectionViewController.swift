//
//  DialogSelfieCamSelectionViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 29/12/22.
//

import UIKit

class DialogSelfieCamSelectionViewController: UIViewController {

    @IBOutlet weak var liveCollectionView: UIView!
    @IBOutlet weak var photoCollectionView: UIView!
    
    @IBOutlet weak var modelCollectionView: UIView!
    
    @IBOutlet weak var modeSelectionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCardView(toView: liveCollectionView)
        setCardView(toView: photoCollectionView)
        setCardView(toView: modelCollectionView)
        setModeSelectionView(toView: modeSelectionView)
    }
    

    func setCardView(toView: UIView)
    {
        toView.layer.cornerRadius = 16
        toView.layer.borderColor = UIColor.black.cgColor
        toView.layer.borderWidth = 1
    }
    
    func setModeSelectionView(toView: UIView)
    {
        toView.layer.cornerRadius = 16
    }

}
