//
//  SignInProfileViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 06/01/23.
//

import UIKit

class SignInProfileViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var apiUtils = ApiUtils()
    var patron = Patron()
   
    let userDefault = UserDefaults.standard
    
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
extension SignInProfileViewController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
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
            if let namecell:SignInFullNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInFullNameTableViewCell",for: indexPath) as? SignInFullNameTableViewCell{
                namecell.txtFullName.tag = indexPath.row
                namecell.txtFullName.delegate = self
                return namecell
            }
        }
        else if indexPath.row == 2 {
             //Gender
            if let emailcell:SignInEmailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInEmailTableViewCell") as? SignInEmailTableViewCell{
                    let email = userDefault.string(forKey: "Email")
                    patron.email = email!
                    emailcell.txtEmailAddress.text! = patron.email
                emailcell.txtEmailAddress.tag = indexPath.row
                emailcell.txtEmailAddress.delegate = self
                return emailcell
            }
        }
        else if indexPath.row == 3 {
            if let phonecell:SignInPhoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInPhoneTableViewCell") as? SignInPhoneTableViewCell{
                    let phone = userDefault.string(forKey: "Phone")
                    patron.phoneNumber = phone!
                    phonecell.txtPhoneNumber.text! = patron.phoneNumber
                phonecell.txtPhoneNumber.tag = indexPath.row
                phonecell.txtPhoneNumber.delegate = self
                return phonecell
            }
        }else if indexPath.row == 4{
            if let gendercell:SignInGenderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInGenderTableViewCell") as? SignInGenderTableViewCell{
                gendercell.btnMale.addTarget(self, action: #selector(btnMale), for: .touchUpInside)
                gendercell.btnFemale.addTarget(self, action: #selector(btnFemale), for: .touchUpInside)
                gendercell.btnOthers.addTarget(self, action: #selector(btnOthers), for: .touchUpInside)
                return gendercell
            }
        }else if indexPath.row == 5{
            if let cell:SignInCompleteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInCompleteTableViewCell") as? SignInCompleteTableViewCell{
                cell.btnComplete.addTarget(self, action: #selector(GoToHome), for: .touchUpInside)
                cell.btnSkip.addTarget(self, action: #selector(skip), for: .touchUpInside)
                return cell
            }
        }
        
       

        return UITableViewCell()
    }
    
    @objc func btnMale(_ sender: UIButton)
    {
        if sender.isSelected
        {
            patron.gender = "Male"
        }
        else
        {
            patron.gender = ""
        }
    }
    
    @objc func btnFemale(_ sender: UIButton)
    {
        if sender.isSelected
        {
            patron.gender = "Female"
        }else
        {
            patron.gender = ""
        }
    }
    
    @objc func btnOthers(_ sender: UIButton)
    {
        if sender.isSelected
        {
            patron.gender = "Others"
        }else
        {
            patron.gender = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let name = NSIndexPath(row: textField.tag, section: 0)
            if let namecell:SignInFullNameTableViewCell = tblView.cellForRow(at: name as IndexPath) as? SignInFullNameTableViewCell {
                if (namecell.txtFullName.text != ""){
                    
                    patron.name = namecell.txtFullName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
        
        let email = NSIndexPath(row: textField.tag, section: 0)
            if let emailcell:SignInEmailTableViewCell = tblView.cellForRow(at: email as IndexPath) as? SignInEmailTableViewCell {
                if (emailcell.txtEmailAddress.text == ""){
    
                    patron.email = emailcell.txtEmailAddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                }
                
                
            }
    
        let phone = NSIndexPath(row: textField.tag, section: 0)
            if let phonecell:SignInPhoneTableViewCell = tblView.cellForRow(at: phone as IndexPath) as? SignInPhoneTableViewCell {
                if (phonecell.txtPhoneNumber.text != ""){
                    patron.phoneNumber = phonecell.txtPhoneNumber.text!.components(separatedBy: .whitespaces).joined()
                }
            
            }
      
    }
    
   
    
    @objc func GoToHome(_ sender: UIButton) {
        if  apiUtils.updateUserDetails(patron: Patron(email: patron.email, phoneNumber: patron.phoneNumber, name: patron.name, gender: patron.gender,profileImage: patron.profileImage))
        {
            let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
            
            detailViewController.modalPresentationStyle = .fullScreen
            self.present(detailViewController, animated: false)
        }
    
    }
    
    @objc func skip(_ sender: UIButton) {
        if apiUtils.updateUserDetails(patron: Patron(email: patron.email, phoneNumber: patron.phoneNumber, name: patron.name, gender: patron.gender,profileImage: patron.profileImage)){
            let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
            
            detailViewController.modalPresentationStyle = .fullScreen
            self.present(detailViewController, animated: false)
        }
        
    
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
