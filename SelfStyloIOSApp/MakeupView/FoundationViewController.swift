//
//  FoundationViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 23/01/23.
//

import UIKit

class FoundationViewController: UIViewController {

    var backToCategory : (()-> Void)?
    
    @IBOutlet weak var customView: CardView!
    @IBOutlet weak var shadesView: CardView!
    @IBOutlet weak var analyzView: CardView!
    
    let colorVC = FoundationColorViewController()
    
    @IBOutlet weak var foundationView: CardView!
    
    @IBOutlet weak var foundationColorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let tapGesCustom = UITapGestureRecognizer(target: self, action: #selector(customFondationAction))
        customView.isUserInteractionEnabled = true
        customView.addGestureRecognizer(tapGesCustom)
        
        let tapGesShades = UITapGestureRecognizer(target: self, action: #selector(shadeFondationAction))
        shadesView.isUserInteractionEnabled = true
        shadesView.addGestureRecognizer(tapGesShades)
        
        let tapGesAnalyze = UITapGestureRecognizer(target: self, action: #selector(analyzeFondationAction))
        analyzView.isUserInteractionEnabled = true
        analyzView.addGestureRecognizer(tapGesAnalyze)
    }
    
    @objc
    func customFondationAction() {
        foundationColorView.isHidden = false
        foundationView.alpha = 0
    }
    
    @objc
    func shadeFondationAction() {
        
    }
    
    @objc
    func analyzeFondationAction() {
        
    }

    @IBAction func btnBack(_ sender: UIButton) {
        backToCategory?()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foundationView" {
            if let foundationColorVC = segue.destination as? FoundationColorViewController {
                foundationColorVC.backToFoundation = {
                    self.foundationColorView.isHidden = true
                    self.foundationView.alpha = 1
                }
            }
        }
    }
   

}
