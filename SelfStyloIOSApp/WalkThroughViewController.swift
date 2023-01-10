//
//  WalkThroughViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 02/01/23.
//

import UIKit

class WalkThroughViewController: UIViewController {

    
    @IBOutlet weak var Step1View: UIView!
    @IBOutlet weak var Step2View: UIView!
    @IBOutlet weak var Step3View: UIView!
    
    
    @IBOutlet weak var liveView: UIView!
    @IBOutlet weak var cosmeticsView: UIView!
    
    @IBOutlet weak var comboView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCardView(toView: Step1View)
        setCardView(toView: Step2View)
        setCardView(toView: Step3View)
        
        setCardView(toView: liveView)
        setCardView(toView: cosmeticsView)
        setCardView(toView: comboView)
        
    }
    

    func setCardView(toView: UIView)
    {
        toView.layer.cornerRadius = 18
    }

}
