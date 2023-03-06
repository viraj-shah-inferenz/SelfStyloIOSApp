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
    
    @objc func editProfile(){
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true)
    }
    
    @objc func GoToHome(_ sender: UIButton) {
        let nameIndex:IndexPath = IndexPath(row: 1, section: 0)
        let nameCell:SignInFullNameTableViewCell = tblView.cellForRow(at: nameIndex) as! SignInFullNameTableViewCell
        let emailIndex:IndexPath = IndexPath(row: 2, section: 0)
        let emailCell:SignInEmailTableViewCell = tblView.cellForRow(at: emailIndex) as! SignInEmailTableViewCell
        let mobileNumIndex = IndexPath(row: 3, section: 0)
        let mobileNumCell: SignInPhoneTableViewCell = tblView.cellForRow(at: mobileNumIndex) as! SignInPhoneTableViewCell
        let genderIndex = IndexPath(row: 4, section: 0)
        let genderCell: SignInGenderTableViewCell = tblView.cellForRow(at: genderIndex) as! SignInGenderTableViewCell
        
        // Empty check
        if let name = nameCell.txtFullName.text {
            if name == "" {
                nameCell.lblInvalidName.text = "Please enter valid name"
                return
            } else {
                patron.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        if let email = emailCell.txtEmailAddress.text {
            if email == "" {
                emailCell.lblInvalidEmail.text = "Please enter valid email address"
                return
            } else  {
                patron.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        if let mobileNo = mobileNumCell.txtPhoneNumber.text {
            if mobileNo == "" {
                mobileNumCell.lblInvalidPhone.text = "Please enter valid mobile number"
                return
            } else {
                patron.phoneNumber = (mobileNumCell.txtPhoneNumber.selectedCountry?.phoneCode.appending(mobileNo))!
            }
        }
        
        if genderCell.gender.isEmpty {
            genderCell.lblInvalidGender.text = "Please select gender"
            return
        }else{
            
            
            if genderCell.gender == "Male"
            {
                genderCell.selectedButton = genderCell.btnMale
            }
            else if genderCell.gender == "Female"
            {
                genderCell.selectedButton = genderCell.btnFemale
            }else if genderCell.gender == "Others"
            {
                genderCell.selectedButton = genderCell.btnOthers
            }
            patron.gender = genderCell.gender
            genderCell.selectedButton.isSelected = true
            
        }
        
        if  apiUtils.updateUserDetails(patron: Patron(email: patron.email, phoneNumber: patron.phoneNumber, name: patron.name, gender: patron.gender,profileImage: patron.profileImage))
        {
            let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
            detailViewController.modalPresentationStyle = .fullScreen
            self.present(detailViewController, animated: false)
        }
        
    }
    
    @objc func skip(_ sender: UIButton) {
        let nameIndex:IndexPath = IndexPath(row: 1, section: 0)
        let nameCell:SignInFullNameTableViewCell = tblView.cellForRow(at: nameIndex) as! SignInFullNameTableViewCell
        let emailIndex:IndexPath = IndexPath(row: 2, section: 0)
        let emailCell:SignInEmailTableViewCell = tblView.cellForRow(at: emailIndex) as! SignInEmailTableViewCell
        let mobileNumIndex = IndexPath(row: 3, section: 0)
        let mobileNumCell: SignInPhoneTableViewCell = tblView.cellForRow(at: mobileNumIndex) as! SignInPhoneTableViewCell
        let genderIndex = IndexPath(row: 4, section: 0)
        let genderCell: SignInGenderTableViewCell = tblView.cellForRow(at: genderIndex) as! SignInGenderTableViewCell
        
        // Empty check
        if let name = nameCell.txtFullName.text {
            if !name.isEmpty{
                patron.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        if let email = emailCell.txtEmailAddress.text {
            if !email.isEmpty{
                patron.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        if let mobileNo = mobileNumCell.txtPhoneNumber.text {
            if !mobileNo.isEmpty
            {
                patron.phoneNumber =  (mobileNumCell.txtPhoneNumber.selectedCountry?.phoneCode.appending(mobileNo))!
            }
            }
            
            if genderCell.gender.isEmpty {
                if genderCell.gender == "Male"
                {
                    genderCell.selectedButton = genderCell.btnMale
                }
                else if genderCell.gender == "Female"
                {
                    genderCell.selectedButton = genderCell.btnFemale
                }else if genderCell.gender == "Others"
                {
                    genderCell.selectedButton = genderCell.btnOthers
                }
                patron.gender = genderCell.gender
                genderCell.selectedButton.isSelected = true
                
            }
            if apiUtils.updateUserDetails(patron: Patron(email: patron.email, phoneNumber: patron.phoneNumber, name: patron.name, gender: patron.gender,profileImage: patron.profileImage)){
                let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "CustomTabBarControllerViewController") as! CustomTabBarControllerViewController
                
                detailViewController.modalPresentationStyle = .fullScreen
                self.present(detailViewController, animated: false)
            }
            
            
        }
    }



extension SignInProfileViewController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SignInPhotoTableViewCell") as? SignInPhotoTableViewCell {
                
                if let profileImageUrl = UserDefaults.standard.url(forKey: "ProfileImageUrl") {
                    patron.profileImage = profileImageUrl.absoluteString
                    cell.profileImageView.sd_setImage(with: URL(string: patron.profileImage), completed: .none)
                }
                cell.edtProfile.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
                return cell
            }
        }
        else if indexPath.row == 1{
            if let namecell:SignInFullNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInFullNameTableViewCell",for: indexPath) as? SignInFullNameTableViewCell{
                if let name = UserDefaults.standard.string(forKey: "FullName")
                {
                    if name == ""
                    {
                        namecell.txtFullName.text! = ""
                    }else
                    {
                        patron.name = name
                        namecell.txtFullName.text! = patron.name
                    }
                }
                namecell.txtFullName.tag = indexPath.row
                namecell.txtFullName.delegate = self
                return namecell
            }
        }
        else if indexPath.row == 2 {
            //Gender
            if let emailcell:SignInEmailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInEmailTableViewCell") as? SignInEmailTableViewCell{
                if let email = UserDefaults.standard.string(forKey: "Email")
                {
                    if email == ""{
                        emailcell.txtEmailAddress.text! = ""
                    }else
                    {
                        patron.email = email
                        emailcell.txtEmailAddress.text! = patron.email
                    }
                }
                emailcell.txtEmailAddress.tag = indexPath.row
                emailcell.txtEmailAddress.delegate = self
                return emailcell
            }
        }
        else if indexPath.row == 3 {
            if let phonecell:SignInPhoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInPhoneTableViewCell") as? SignInPhoneTableViewCell{
                
                if let phone = UserDefaults.standard.string(forKey: "Phone")
                {
                    if phone == ""
                    {
                        phonecell.txtPhoneNumber.text! = ""
                    
                    }else
                    {
                        let result4 = String(phone.dropFirst(3))
                        patron.phoneNumber = result4
                        phonecell.txtPhoneNumber.text! = patron.phoneNumber
                    }
                }
                phonecell.txtPhoneNumber.tag = indexPath.row
                phonecell.txtPhoneNumber.delegate = self
                return phonecell
            }
        }else if indexPath.row == 4{
            if let gendercell:SignInGenderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SignInGenderTableViewCell") as? SignInGenderTableViewCell{
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
            
            return 120.0
        }
        else if indexPath.row == 5 {
            
            return 140.0
        }
        
        return 0
    }
}

extension SignInProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let indexpath = IndexPath(row: 0, section: 0)
        guard let cell: SignInPhotoTableViewCell = tblView.cellForRow(at: indexpath) as? SignInPhotoTableViewCell else { return }
        cell.profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if let img = cell.profileImageView.image {
            guard let base64img = img.base64(format: .jpeg(1.0)) else { return }
            patron.profileImage = base64img
        }
        cell.profileImageView.image = patron.profileImage.imageFromBase64()
        self.dismiss(animated: true,completion: nil)
    }
}
