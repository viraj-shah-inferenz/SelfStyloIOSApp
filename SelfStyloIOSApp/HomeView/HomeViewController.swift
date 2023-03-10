//
//  ViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 27/12/22.
//

import UIKit
import Toast_Swift


class HomeViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var apiUtils = ApiUtils()
    var favouriteProductData = [FavouriteProductData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegates()
        self.tblView.register(UINib(nibName: "SelectLogoAppTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectLogoAppTableViewCell")
        self.tblView.register(UINib(nibName: "HomeCardAnnouncementsTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCardAnnouncementsTableViewCell")
        self.tblView.register(UINib(nibName: "HomeCardSelfiecamTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCardSelfiecamTableViewCell")
        self.tblView.register(UINib(nibName: "FavouriteProductTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteProductTableViewCell")
        self.tblView.register(UINib(nibName: "SavedPresetsTableViewCell", bundle: nil), forCellReuseIdentifier: "SavedPresetsTableViewCell")
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
        print(self.tabBarController?.tabBar.selectedItem?.tag)
        
        loadFavouriteProducts()
    }
    
    func loadFavouriteProducts() {
        let api = IApiCalls()
        let uuid = "4aa6223c-8439-4ed3-8de0-f6a67b1d36bd"  //UUID().uuidString
        let apiUrl = ApiUtils.MAKEUP_URL + api.product_like + "?id=\(uuid)"
        apiUtils.makeRequest(fronUrl: apiUrl) { Result in
            switch Result {
                
            case .success(let data):
                do {
                    let list = try? JSONDecoder().decode(FavouriteProducts.self, from: data)
                    print(list?.data?[0].colorName)
                    if let list = list?.data {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: NSNotification.Name("loadFavouriteItem"), object: list)
                        }
                    }
                } catch let error {
                    self.view.makeToast(error.localizedDescription, duration: 3.0, position: .bottom)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func setDelegates() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SelectLogoAppTableViewCell") as? SelectLogoAppTableViewCell {
                return cell
            }
        }else if indexPath.row == 1{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCardAnnouncementsTableViewCell") as? HomeCardAnnouncementsTableViewCell{
                return cell
            }
        }else if indexPath.row == 2{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCardSelfiecamTableViewCell") as? HomeCardSelfiecamTableViewCell{
                return cell
            }
        }else if indexPath.row == 3{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteProductTableViewCell") as? FavouriteProductTableViewCell {
                cell.btnFavouriteDetails.addTarget(self, action: #selector(favouriteviewall), for: .touchUpInside)
                return cell
            }
        }else if indexPath.row == 4{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SavedPresetsTableViewCell") as? SavedPresetsTableViewCell{
                cell.btnSave.addTarget(self, action: #selector(savepresetsviewall), for: .touchUpInside)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70.0
        }else if indexPath.row == 1{
            return 190.0
        } else if indexPath.row == 2{
            return 190.0
        } else if indexPath.row == 3{
            return 230.0
        } else if indexPath.row == 4{
            return 250.0
        }
        
        return 0
    }
    
    @objc func favouriteviewall(){
        self.tabBarController?.selectedIndex = 1
    }
    
    @objc func savepresetsviewall(){
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "SavePresetsViewController") as! SavePresetsViewController
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
    fileprivate func openCamera() {
        let detailViewController:MakeupLoaderViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MakeupLoaderViewController") as! MakeupLoaderViewController
        detailViewController.modalPresentationStyle = .fullScreen
        detailViewController.delegate = self
        
        self.navigationController?.present(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCardSelfiecamTableViewCell") as? HomeCardSelfiecamTableViewCell{
                cell.homeCardBtnSelfiecam.backgroundColor = UIColorFromHex(rgbValue: 0x0D0F17, alpha: 0.2)
                openCamera()
            }
        }
    }
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
}


extension HomeViewController: MakeupLoaderDelegate {
    func didLoadMakeup(vc: UIViewController) {
        
        vc.dismiss(animated: true)
        
        let makeupVC = self.storyboard?.instantiateViewController(withIdentifier: "MakeupViewController") as! MakeupViewController
        makeupVC.modalPresentationStyle = .fullScreen
        self.present(makeupVC, animated: true)
    }
}
