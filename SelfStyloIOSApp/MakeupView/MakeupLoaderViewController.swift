//
//  MakeupLoaderViewController.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 01/02/23.
//

import UIKit
protocol MakeupLoaderDelegate {
    func didLoadMakeup(vc: UIViewController)
}
class MakeupLoaderViewController: UIViewController {

    @IBOutlet weak var lblLoading: UILabel!
    var apiUtils = ApiUtils()
    
    var makeup = MakeDetails()
    var eyeshadowVC = EyeshadowViewController()
    
    var eyeliner: EyelinerModel!
    
    var delegate: MakeupLoaderDelegate?
    
    var eyelinerData: Dictionary = [String: String]()
    var numOfDownload = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLoading.isHidden = false
        fetchEyelinerStyle()
    }
    
    func fetchEyelinerStyle() {
        eyelinerData.removeAll()
        DispatchQueue.global(qos: .background).async {
            self.apiUtils.fetchEyelinerStyles { eyelinerModel in
                DispatchQueue.main.sync {
                    if let eyeliner = eyelinerModel {
                        self.eyeliner = eyeliner
                        guard let count = self.eyeliner.data?.count else { return }
                        if count > 0 {
                            self.setUpData()
                        }
                    }
                }
            }
        }
    }
    
    func setUpData() {
        if let eyelinerStyle = self.eyeliner.data {
            for data in eyelinerStyle {
                if let img = data.eyelinerStyleImage {
                    let domainUrl = ApiUtils.MAKEUP_URL.dropLast()
                    guard let url = URL(string: domainUrl + img) else { return }
                    
                    guard let styleId = data.id else { return }
                    downloadImage(from: url,id: String(styleId))
                    numOfDownload += 1
                }
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let req = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 800)
        URLSession.shared.dataTask(with: req, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL, id: String) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            self.eyelinerData.updateValue(data.base64EncodedString(), forKey:id)
            
            if self.eyelinerData.count == self.numOfDownload {
                print(self.eyelinerData.count)
                
                UserDefaults.standard.set(self.eyelinerData, forKey: APP.EYELINER_STYLE)
                UserDefaults.standard.synchronize()
                
                self.fetchData()
            }
        }
    }
    
    
    
    fileprivate func fetchData() {
        DispatchQueue.global(qos: .background).async {
            self.apiUtils.fetchMakeupDetails { makeupDetails in
                DispatchQueue.main.sync {
                    if let mkup = makeupDetails {
                        self.makeup = mkup
                        if self.makeup.data?.makeup?.count ?? 0 > 0 {
                            self.delegate?.didLoadMakeup(vc: self)
                        } else {
                            
                        }
                    }
                }
            }
        }
    }

}

extension Dictionary {
    var jsonStringRepresentaiton: String? {
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }

        return String(data: theJSONData, encoding: .ascii)
    }
}
