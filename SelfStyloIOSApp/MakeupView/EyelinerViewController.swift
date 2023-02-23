//
//  EyelinerViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 23/01/23.
//

import UIKit

class EyelinerViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var eyelinerCollectionView: UICollectionView!
    
    @IBOutlet weak var eyelinerCV: UIView!
    
    
    @IBOutlet weak var eyelinerStyleCV: UIView!
    
    var apiUtils = ApiUtils()
    
    var eyeliner: EyelinerModel!
    
    var arrEyelinerData = [EyelinerData]()
    
    var backToCategory : (()-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        reloadCollectionViewData()
        
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
        arrEyelinerData.removeAll()
        var eyelinerData: Dictionary = [String: String]()
        if let eyelinerStyle = self.eyeliner.data {
            
            for data in eyelinerStyle {
                arrEyelinerData.append(data)
            }
        }
        
        self.eyelinerCollectionView.reloadData()
    }
    
    func loadEyelinerStyleImagesJs(strJson: String) {
        
    }
    
    
    /*func fetchingImage() {
        for data in arrEyelinerData {
            guard let imgUrl = data.eyelinerStyleImage else { return }
            let domainUrl = ApiUtils.MAKEUP_URL.dropLast()
            guard let url = URL(string: domainUrl + imgUrl) else { return }
            let request: URLRequest = URLRequest(
                url: url,
                cachePolicy: .returnCacheDataElseLoad,
                timeoutInterval: 300
            )
            
            let dataTask = try! URLSession.shared.dataTask(with: request) { data, res, err in
                if err == nil {
                    guard data != nil else {
                        let base64String = data?.base64EncodedString()
                        print(base64String ?? "Not sucessfully convert in base64")
                        return
                    }
                    
                } else {
                    print("Something went wrong...")
                }
            }
            dataTask.resume()
        }
        
    }*/
    
    @IBAction func btnBack(_ sender: UIButton) {
        backToCategory?()
    }
    
    func reloadCollectionViewData() {
        self.eyelinerCollectionView.reloadData()
    }
    
    func setDelegates()
    {
        eyelinerCollectionView.delegate = self
        eyelinerCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eyelinerStyleView" {
            if let eyelinerStyleVC = segue.destination as? EyelinerStyleViewController {
                eyelinerStyleVC.backToCategory = {
                    self.backToCategory?()
                }
                eyelinerStyleVC.backToEyeliner = {
                    self.eyelinerCV.isHidden = true
                    self.eyelinerStyleCV.alpha = 1
                }
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arrEyelinerData.count > 0{
            return arrEyelinerData.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = eyelinerCollectionView.dequeueReusableCell(withReuseIdentifier: "EyelinerStyleCollectionViewCell", for: indexPath) as! EyelinerStyleCollectionViewCell
        
        cell.contentView.backgroundColor = .lightText
        let eyeliner = arrEyelinerData[indexPath.item]
        
        if let iconUrl = eyeliner.eyelinerStyleIcon, let name = eyeliner.eyelinerStyleName, let styleId = eyeliner.id {
            let domainUrl = String(ApiUtils.MAKEUP_URL.dropLast())
            print(domainUrl + iconUrl)
            
            cell.eyelinerImage.DownloadedFrom(link:  domainUrl + iconUrl)
            cell.eyelinerName.text = name
            
            if cell.imgEyelinerImage.image != nil {
                let strBase64 = cell.imgEyelinerImage.image?.base64(format: .png)
                if strBase64 != nil {
                    let style = EyelinerStyle(styleId: String(styleId), style: strBase64!)
                    do {
                        let jsonEncoder = JSONEncoder()
                        let jsonData = try jsonEncoder.encode(style)
                        var json = String(data: jsonData, encoding: String.Encoding.utf8)!
                        print(json)
                        
                    } catch let e {
                        print(e.localizedDescription)
                    }
                }
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = arrEyelinerData[indexPath.item]
        if let styleId = product.id {
            UserDefaults.standard.set(styleId, forKey: APP.EYELINER_STYLE_Id)
            UserDefaults.standard.synchronize()
        }
        eyelinerCV.isHidden = false
        eyelinerStyleCV.alpha = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2 - 25, height: bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
}
