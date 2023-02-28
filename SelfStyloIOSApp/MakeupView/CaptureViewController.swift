//
//  CaptureViewController.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 28/02/23.
//

import UIKit

class CaptureViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgCapturedImage: UIImageView!
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var capturedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    
    fileprivate func setupData() {
        btnShare.layer.cornerRadius = 12.0
        btnShare.clipsToBounds = true
        
        btnSave.layer.cornerRadius = 12.0
        btnSave.clipsToBounds = true
        
        imgCapturedImage.image = capturedImage
        
        btnBack.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    @objc func backAction() {
        self.dismiss(animated: true)
    }
    
    @IBAction func shareImageAction(_ sender: UIButton) {
        if let img = self.imgCapturedImage.image {
            let activityViewController = UIActivityViewController(activityItems: [img], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func saveImageAction(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(self.imgCapturedImage.image!, nil, nil, nil)
        dismiss(animated: true)
    }
}
