//
//  EditProfileViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 30/12/22.
//

import UIKit

class EditProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tblView: UITableView!
    let userDefault = UserDefaults.standard
    let db = PatronDao()
   // var patron = Patron()
    var patron:[Patron] = []
    
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
        patron = db.getAll()
    }
    
    func setDelegates() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }
}
extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPhotoTableViewCell") as? SelectPhotoTableViewCell {
                cell.edtProfile.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
                return cell
            }
        }
        else if indexPath.row == 1{
            // Nsme
            if let namecell:SelectFullNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectFullNameTableViewCell") as? SelectFullNameTableViewCell{
                    let name = userDefault.string(forKey: "Name")
                    namecell.txtFullName.text = name
                    namecell.txtFullName.tag = indexPath.row
                    namecell.txtFullName.delegate = self
                return namecell
            }
        }
        else if indexPath.row == 2 {
             //Gender
            if let emailcell:SelectEmailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectEmailTableViewCell") as? SelectEmailTableViewCell{
                let email = userDefault.string(forKey: "Email")
                emailcell.txtEmailAddress.text = email
                emailcell.txtEmailAddress.tag = indexPath.row
                emailcell.txtEmailAddress.delegate = self
                return emailcell
            }
        } else if indexPath.row == 3 {
            if let phonecell:SelectPhoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectPhoneTableViewCell") as? SelectPhoneTableViewCell{
                let phone = userDefault.string(forKey: "Phone")
                phonecell.txtPhoneNumber.text = phone
                phonecell.txtPhoneNumber.tag = indexPath.row
                phonecell.txtPhoneNumber.delegate = self
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
            patron[0].gender = "Male"
        }
    }
    
    @objc func btnFemale(_ sender: UIButton)
    {
        if sender.isSelected
        {
            patron[0].gender = "Female"
        }
    }
    
    @objc func btnOthers(_ sender: UIButton)
    {
        if sender.isSelected
        {
            patron[0].gender = "Others"
        }
    }
    
    @objc func editProfile(){
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let indexpath = IndexPath(row: 0, section: 0)
        guard let cell: SelectPhotoTableViewCell = tblView.cellForRow(at: indexpath) as? SelectPhotoTableViewCell else { return }
        cell.profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if let img = cell.profileImageView.image {
            guard let base64img = img.base64(format: .jpeg(1.0)) else { return }
            patron[0].profileImage = base64img
        }
        cell.profileImageView.image = patron[0].profileImage.imageFromBase64()
        self.dismiss(animated: true,completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {   //delegate method
        
        
        let name = NSIndexPath(row: textField.tag, section: 0)
            if let namecell:SelectFullNameTableViewCell = tblView.cellForRow(at: name as IndexPath) as? SelectFullNameTableViewCell {
                    patron[0].name = namecell.txtFullName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        
        let email = NSIndexPath(row: textField.tag, section: 0)
            if let emailcell:SelectEmailTableViewCell = tblView.cellForRow(at: email as IndexPath) as? SelectEmailTableViewCell{
                    patron[0].email = emailcell.txtEmailAddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        
        
        let phone = NSIndexPath(row: textField.tag, section: 0)
            if let phonecell:SelectPhoneTableViewCell = tblView.cellForRow(at: phone as IndexPath) as? SelectPhoneTableViewCell {
                    patron[0].phoneNumber = phonecell.txtPhoneNumber.text!
            
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
        if db.update(patron: patron[0])
        {
            let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
            
            detailViewController.modalPresentationStyle = .fullScreen
            self.present(detailViewController, animated: false)
        }
    }
    
}
