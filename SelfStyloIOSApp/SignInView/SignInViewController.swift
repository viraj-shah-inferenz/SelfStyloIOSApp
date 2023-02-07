//
//  SignInViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit
import FlagPhoneNumber
import FirebaseAuth

class SignInViewController: UIViewController,UITextFieldDelegate {
    
    

    
   
    @IBOutlet weak var EmailIdView: UIView!
    
    @IBOutlet weak var PhoneView: UIView!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    @IBOutlet weak var btnProceed: UIButton?
    
    var apiUtils = ApiUtils()
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var lblInvalidEmail: UILabel!
    
    let validityType: String.ValidityType = .email
   
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblInvalidPhone: UILabel!
    let validityPhoneType: String.ValidityType = .phone
    
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .plain)
    var repository: FPNCountryRepository = FPNCountryRepository()
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
    
    let userDefault = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        setApiUtils()
        setbtnProceedView(toView: btnProceed!)
        btnProceed?.addTarget(self, action: #selector(btnproceed), for: .touchUpInside)
        setTextFieldEmail()
        setTextFieldPhone()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.tabBar.isHidden = true
//        // hide here
//    }
    
    func setTextFieldEmail(){
        self.EmailIdView.isHidden = false
        txtEmailAddress.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: (txtEmailAddress.frame.height)))
        txtEmailAddress.leftViewMode = .always
        txtEmailAddress.addTarget(self, action: #selector(handleEmailTextChange), for: .editingChanged)
        
        txtEmailAddress.delegate = self
    }
    
    func setTextFieldPhone(){
        self.PhoneView.isHidden = true
        phoneNumberTextField.addTarget(self, action: #selector(handlePhoneTextChange), for: .editingChanged)
        
        phoneNumberTextField.displayMode = .list
        phoneNumberTextField.delegate = self
        
        
        listController.setup(repository: phoneNumberTextField.countryRepository)
        
        listController.didSelect = { [weak self] country in
            self?.phoneNumberTextField.setFlag(countryCode: country.code)
        }
        phoneNumberTextField.font = UIFont.systemFont(ofSize: 14)
        
        // Custom the size/edgeInsets of the flag button
        phoneNumberTextField.flagButtonSize = CGSize(width: 35, height: 35)
        phoneNumberTextField.flagButton.largeContentImageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: nil),
            UIBarButtonItem(title: "Item 1", style: .plain, target: self, action: nil),
            UIBarButtonItem(title: "Item 2", style: .plain, target: self, action: nil)
        ]
        phoneNumberTextField.textFieldInputAccessoryView = getCustomTextFieldInputAccessoryView(with: items)
        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.setFlag(countryCode: .IN)
        setTextFieldView(toView: phoneNumberTextField)
    }
    
    func setApiUtils(){
        apiUtils.getBanner()
        apiUtils.getFavouriteProductDetail()
    }
    
  
    @objc fileprivate func handleEmailTextChange(){
        guard let email = txtEmailAddress.text else { return }
        if email.isValid(validityType) {
            lblInvalidEmail.text = " "
            
        }else
        {
            lblInvalidEmail.text = "Not a Valid \(validityType)"
        }
    }
    
    @objc fileprivate func handlePhoneTextChange(){
        guard let phone = phoneNumberTextField.text else { return }
        if phone.isValid(validityPhoneType){
            lblInvalidPhone.text = " "
        }else
        {
            lblInvalidPhone.text = "Not a Valid \(validityType)"
        }
    }
  

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{
        guard let email = txtEmailAddress.text, !email.isEmpty, email.count > 0  else {
            return false
        }
        
        guard let phone = phoneNumberTextField.text, !phone.isEmpty, phone.count > 0 else
        {
            return false
        }

       
        return true
    }
    
    @objc func btnproceed(){
            if txtEmailAddress.text == "" && phoneNumberTextField.text == "" {
                lblInvalidEmail.text = "Please enter valid email address"
                lblInvalidPhone.text = "Please enter valid phone number"
          } else {
              let patron = Patron(email: txtEmailAddress.text!)
          let trimmed = patron.email.trimmingCharacters(in: .whitespacesAndNewlines)
              apiUtils.sendEmailOtp(email: trimmed)
              self.userDefault.set(trimmed, forKey: "Email")
              guard let phoneNumber = phoneNumberTextField.text else {return}
              Auth.auth().settings?.isAppVerificationDisabledForTesting = false
              PhoneAuthProvider.provider(auth: Auth.auth())
              self.userDefault.set(phoneNumber, forKey: "Phone")
              let str  = phoneNumber.components(separatedBy: .whitespaces).joined()
              PhoneAuthProvider.provider().verifyPhoneNumber(str, uiDelegate: nil){(verificationId, error) in
                  if error == nil{
                      print(verificationId)
                      guard let verifyId = verificationId else {return}
                      self.userDefault.set(verifyId, forKey: "verificationId")
                      self.userDefault.synchronize()
                  }else
                  {
                      print("Unable to get Secret Varification Code from firebase",error?.localizedDescription)
                  }

              }

              performSegue(withIdentifier: "moveToOtp", sender: self)

          }
     
        
    }
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.EmailIdView.isHidden = false
            self.PhoneView.isHidden = true
        }else
        {
            self.EmailIdView.isHidden = true
            self.PhoneView.isHidden = false
        }
    }
    
    
    func setbtnProceedView(toView: UIButton)
    {
        toView.layer.cornerRadius = 20
    }
    
    
    @IBAction func btnSelectCheckbox(_ sender: UIButton) {
        if btnCheckbox.isSelected && btnProceed?.isEnabled == true{
            btnCheckbox.setImage(UIImage.init(named: "unchecked"), for: .normal)
            btnProceed?.isEnabled = false
            btnProceed?.backgroundColor = UIColor.darkGray
            btnProceed?.setTitleColor(UIColor.black, for: .normal)
        }else
        {
            btnCheckbox.setImage(UIImage.init(named: "checked"), for: .normal)
            btnProceed?.isEnabled = true
            btnProceed?.backgroundColor = UIColor.black
            btnProceed?.setTitleColor(UIColor.white, for: .normal)
        }
        btnCheckbox.isSelected = !btnCheckbox.isSelected
    }
    
    private func getCustomTextFieldInputAccessoryView(with items: [UIBarButtonItem]) -> UIToolbar {
        let toolbar: UIToolbar = UIToolbar()
        
        toolbar.barStyle = UIBarStyle.default
        toolbar.items = items
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    
    
    func setTextFieldView(toView: UIView){
        toView.layer.cornerRadius = 18
        toView.layer.borderWidth = 1
        toView.layer.backgroundColor = UIColor.white.cgColor
        toView.layer.borderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7).cgColor
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            var is_check : Bool
            let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            is_check = string == numberFiltered
            
            if is_check {
                let maxLength = 11
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                is_check = newString.length <= maxLength
            }
            return is_check
            
        }else {
            return true
        }
        
    }
    
    
    @objc func dismissCountries() {
        listController.dismiss(animated: true, completion: nil)
    }
    
}


extension SignInViewController: FPNTextFieldDelegate {
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))
        
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        textField.rightViewMode = .always
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
       // print(name, dialCode, code)
    }
    
}
