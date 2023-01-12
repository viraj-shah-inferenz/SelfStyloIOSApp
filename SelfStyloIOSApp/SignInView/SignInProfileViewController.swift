//
//  SignInProfileViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 06/01/23.
//

import UIKit

class SignInProfileViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setDelegates()
        // Do any additional setup after loading the view.
        self.tblView.register(UINib(nibName: "SignInPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "SignInPhotoTableViewCell")
        self.tblView.register(UINib(nibName: "SignInFullNameTableViewCell", bundle: nil), forCellReuseIdentifier: "SignInFullNameTableViewCell")
        self.tblView.register(UINib(nibName: "SignInEmailTableViewCell", bundle: nil), forCellReuseIdentifier: "SignInEmailTableViewCell")
        self.tblView.register(UINib(nibName: "SignInPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "SignInPhoneTableViewCell")
        self.tblView.register(UINib(nibName: "SignInGenderTableViewCell", bundle: nil), forCellReuseIdentifier: "SignInGenderTableViewCell")
        self.tblView.register(UINib(nibName: "SignInCompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "SignInCompleteTableViewCell")
    }
    

    func setDelegates() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }
    
    
    @IBAction func backSignIn(_ sender: UIButton) {
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
}
extension SignInProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SignInPhotoTableViewCell") as? SignInPhotoTableViewCell {
                return cell
            }
        }
        else if indexPath.row == 1{
            // Nsme
            if let namecell:SignInFullNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInFullNameTableViewCell") as? SignInFullNameTableViewCell{
                return namecell
            }
        }
        else if indexPath.row == 2 {
             //Gender
            if let emailcell:SignInEmailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInEmailTableViewCell") as? SignInEmailTableViewCell{
                return emailcell
            }
        } else if indexPath.row == 3 {
            if let phonecell:SignInPhoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInPhoneTableViewCell") as? SignInPhoneTableViewCell{
                return phonecell
            }
        }else if indexPath.row == 4{
            if let gendercell:SignInGenderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInGenderTableViewCell") as? SignInGenderTableViewCell{
                return gendercell
            }
        }else if indexPath.row == 5{
            if let cell:SignInCompleteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInCompleteTableViewCell") as? SignInCompleteTableViewCell{
                cell.btnComplete.addTarget(self, action: #selector(GoToHome), for: .touchUpInside)
                return cell
            }
        }

        return UITableViewCell()
    }
    
   
    
    @objc func GoToHome(_ sender: UIButton) {
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 190.0
        } else if indexPath.row == 1 {
            
            return 120.0
        } else if indexPath.row == 2 {
            
            return 120.0
        } else if indexPath.row == 3 {
            
            return 120.0
        }
        else if indexPath.row == 4 {
           
           return 100.0
       }
        else if indexPath.row == 5 {
           
            return 120.0
       }
        
        return 0
    }
    
    
}
