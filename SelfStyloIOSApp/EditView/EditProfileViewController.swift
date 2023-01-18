//
//  EditProfileViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 30/12/22.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    let userDefault = UserDefaults.standard
    let db = PatronDao()
    var patron = Patron()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        // Do any additional setup after loading the view.
        self.tblView.register(UINib(nibName: "SelectPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectPhotoTableViewCell")
        self.tblView.register(UINib(nibName: "SelectFullNameTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectFullNameTableViewCell")
        self.tblView.register(UINib(nibName: "SelectEmailTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectEmailTableViewCell")
        self.tblView.register(UINib(nibName: "SelectPhoneTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectPhoneTableViewCell")
        self.tblView.register(UINib(nibName: "SelectGenderTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectGenderTableViewCell")
        self.tblView.register(UINib(nibName: "CompleteTableViewCell", bundle: nil), forCellReuseIdentifier: "CompleteTableViewCell")
    }
    
    func setDelegates() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }
}
extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPhotoTableViewCell") as? SelectPhotoTableViewCell {
                return cell
            }
        }
        else if indexPath.row == 1{
            // Nsme
            if let namecell:SelectFullNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectFullNameTableViewCell") as? SelectFullNameTableViewCell{
                let name = userDefault.string(forKey: "Name")
                namecell.txtFullName.text = name
                patron.name = namecell.txtFullName.text!
                return namecell
            }
        }
        else if indexPath.row == 2 {
             //Gender
            if let emailcell:SelectEmailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectEmailTableViewCell") as? SelectEmailTableViewCell{
                let email = userDefault.string(forKey: "Email")
                emailcell.txtEmailAddress.text = email
                patron.email = emailcell.txtEmailAddress.text!
                return emailcell
            }
        } else if indexPath.row == 3 {
            if let phonecell:SelectPhoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectPhoneTableViewCell") as? SelectPhoneTableViewCell{
                let phone = userDefault.string(forKey: "Phone")
                phonecell.txtPhoneNumber.text = phone
                patron.phoneNumber = phonecell.txtPhoneNumber.text!
                return phonecell
            }
        }else if indexPath.row == 4{
            if let gendercell:SelectGenderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectGenderTableViewCell") as? SelectGenderTableViewCell{
                gendercell.btnMale.addTarget(self, action: #selector(btnMale), for: .touchUpInside)
                gendercell.btnFemale.addTarget(self, action: #selector(btnFemale), for: .touchUpInside)
                gendercell.btnOthers.addTarget(self, action: #selector(btnOthers), for: .touchUpInside)
                return gendercell
            }
        }else if indexPath.row == 5{
            if let cell:CompleteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompleteTableViewCell") as? CompleteTableViewCell{
                cell.btnComplete.addTarget(self, action: #selector(updateUserDetails), for: .touchUpInside)
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
    }
    
    @objc func btnFemale(_ sender: UIButton)
    {
        if sender.isSelected
        {
            patron.gender = "Female"
        }
    }
    
    @objc func btnOthers(_ sender: UIButton)
    {
        if sender.isSelected
        {
            patron.gender = "Others"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
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
           
            return 100.0
       }
        
        return 0
    }
    
    @objc func updateUserDetails(){
        if db.update(patron: patron)
        {
            self.tabBarController?.selectedIndex = 4
        }
    }
    
}
