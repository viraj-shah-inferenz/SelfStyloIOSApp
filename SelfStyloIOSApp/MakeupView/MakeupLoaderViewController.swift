//
//  MakeupLoaderViewController.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 01/02/23.
//

import UIKit

class MakeupLoaderViewController: UIViewController {

    var apiUtils = ApiUtils()
    
    var makeup = MakeDetails()
    var eyeshadowVC = EyeshadowViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    fileprivate func fetchData() {
        DispatchQueue.global(qos: .background).async {
            self.apiUtils.fetchMakeupDetails { makeupDetails in
                DispatchQueue.main.sync {
                    if let mkup = makeupDetails {
                        self.makeup = mkup
                        if self.makeup.data?.makeup?.count ?? 0 > 0 {
//                            print(self.makeup.data?.makeup?[0].makeupName!)
                            let makeupVC = self.storyboard?.instantiateViewController(withIdentifier: "MakeupViewController") as! MakeupViewController
//                            makeupVC.makeup = mkup
                            self.eyeshadowVC.makeup = self.makeup
                            makeupVC.modalPresentationStyle = .fullScreen
                            self.present(makeupVC, animated: true)
                        } else {
                            
                        }
                    }
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
