//
//  SignInViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 04/01/23.
//

import UIKit
import FlagPhoneNumber
import FirebaseAuth
import AuthenticationServices
import SafariServices
import GoogleSignIn
import Toast_Swift
import JGProgressHUD

class SignInViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate{
    
    

    
   
    @IBOutlet weak var EmailIdView: UIView!
    
    @IBOutlet weak var PhoneView: UIView!
    
    @IBOutlet weak var btnCheckbox: UIButton!
    
    @IBOutlet weak var btnProceed: UIButton?
    
    
    @IBOutlet weak var txtView: UITextView!
    
    var apiUtils = ApiUtils()
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtEmailAddress: UITextField!
    
    @IBOutlet weak var lblInvalidEmail: UILabel!
    
    let validityType: String.ValidityType = .email
   
    @IBOutlet weak var signInGoogle: CardView!
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var lblInvalidPhone: UILabel!
    let validityPhoneType: String.ValidityType = .phone
    
    @IBOutlet weak var phoneNumberTextField: FPNTextField!
    
    
    @IBOutlet weak var signInApple: CardView!
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .plain)
    var repository: FPNCountryRepository = FPNCountryRepository()
    
    
    let userDefault = UserDefaults.standard
    let appleProvider = AppleSignInClient()
    

    let termsAndConditionsURL = "https://selfstylo.com/terms-and-conditions/";
    let privacyURL            = "https://selfstylo.com/privacy-policy/";
    
    let hud = JGProgressHUD()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        setbtnProceedView(toView: btnProceed!)
        btnProceed?.addTarget(self, action: #selector(btnproceed), for: .touchUpInside)
        setTextFieldEmail()
        setTextFieldPhone()
        
        setUpSignInAppleButton()
        setUpSignInGoogleButton()
        getData()
        setUpTextView()
    }
    
    
    
    func setUpTextView()
    {
        txtView.isUserInteractionEnabled = true
        self.txtView.delegate = self
        
        
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.underlineColor: UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "DMSans-Medium", size: 12.0),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let str = "I agree to StyloCam's Terms of Use and Privacy Policy"
        let attributedString = NSMutableAttributedString(string: str,attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        var foundRange = attributedString.mutableString.range(of: "Terms of Use")
        //mention the parts of the attributed text you want to tap and get an custom action
        attributedString.addAttribute(NSAttributedString.Key.link, value: termsAndConditionsURL, range: foundRange)
        foundRange = attributedString.mutableString.range(of: "Privacy Policy")
        attributedString.addAttribute(NSAttributedString.Key.link, value: privacyURL, range: foundRange)
        txtView.linkTextAttributes = linkAttributes
        txtView.attributedText = attributedString
    }
    
    func setUpSignInAppleButton() {
        signInApple.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAppleIdRequest)))

    }
    
    @objc func handleAppleIdRequest() {
        appleProvider.handleAppleIdRequest(block: { fullName, email, token in
                    // receive data in login class.
            let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "SignInProfileViewController") as! SignInProfileViewController
            
            detailViewController.modalPresentationStyle = .fullScreen
            self.present(detailViewController, animated: false)
                    
                    
                })
    }
    
    func setUpSignInGoogleButton()
    {
        signInGoogle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGoogleIdRequest)))
    }
    
    @objc func handleGoogleIdRequest() {
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
                guard error == nil else {
                    // ...
                    return
                }
                
                guard let user = result?.user,let idToken = user.idToken?.tokenString else {return}
                
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: user.accessToken.tokenString)
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error{
                        print("Error because \(error.localizedDescription)")
                        return
                    }else{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInProfileViewController") as! SignInProfileViewController
                            profileVC.modalPresentationStyle = .fullScreen
                            self.present(profileVC, animated: false)
                        }
                        if let imgUrl: URL = user.profile?.imageURL(withDimension: 100) as? URL {
                            print(imgUrl)
                            UserDefaults.standard.set(imgUrl, forKey: "ProfileImageUrl")
                            UserDefaults.standard.synchronize()
                        }
                        
                        let name = user.profile?.name
                        UserDefaults.standard.set(name, forKey: "FullName")
                        UserDefaults.standard.synchronize()
                        let email = user.profile?.email
                        UserDefaults.standard.set(email, forKey: "Email")
                        UserDefaults.standard.synchronize()
//                        self.view.makeToast("Sign in successfully...", duration: 3.0, position: .bottom)
                        self.hud.indicatorView = JGProgressHUDImageIndicatorView(image: UIImage(named: "about_selfstylo_logo_app")!)
                        self.hud.progress = 3.0
                        self.hud.show(in: self.view)
                        self.hud.dismiss(afterDelay: 3.0)
                        UserDefaults.standard.set("true", forKey: APP.IS_LOGIN)
                        UserDefaults.standard.synchronize()
                        
                    }
                    // At this point, our user is signed in
                }
                // ...
        }
    }
    
  
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        let safariVC = SFSafariViewController(url: URL)
         safariVC.delegate = self
            if (URL.absoluteString == termsAndConditionsURL) {
                 present(safariVC, animated: true, completion: nil)
            } else if (URL.absoluteString == privacyURL) {
                present(safariVC, animated: true, completion: nil)
            }
            return false
        }
 
    
    func getData(){
        apiUtils.getBanner()
        apiUtils.getFavouriteProductDetail()
    }
    
    func setTextFieldEmail(){
        self.EmailIdView.isHidden = true
        txtEmailAddress.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: (txtEmailAddress.frame.height)))
        txtEmailAddress.leftViewMode = .always
        txtEmailAddress.addTarget(self, action: #selector(handleEmailTextChange), for: .editingChanged)
        
        txtEmailAddress.delegate = self
    }
    
    func setTextFieldPhone(){
        self.PhoneView.isHidden = false
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
    
    
    
    
    
  
    @objc fileprivate func handleEmailTextChange(){
        guard let email = txtEmailAddress.text else { return }
        if email.isValid(validityType) {
            lblInvalidEmail.text = " "
            
        }else
        {
            lblInvalidEmail.text = "Invalid Email"
        }
    }
    
    @objc fileprivate func handlePhoneTextChange(){
        guard let phone = phoneNumberTextField.text else { return }
        if phone.isValid(validityPhoneType){
            lblInvalidPhone.text = " "
        }else
        {
            lblInvalidPhone.text = "Invalid Phone Number"
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
      
            if PhoneView.isHidden == false {
                if  phoneNumberTextField.text == "" {
                    lblInvalidPhone.text = "Please enter valid phone number"
                    lblInvalidEmail.text = ""
                } else {
                    
                    guard let phoneNumber = phoneNumberTextField.text else {return}
                    print(phoneNumber)
                    
                    
                    
                    Auth.auth().settings?.isAppVerificationDisabledForTesting = false
                    PhoneAuthProvider.provider(auth: Auth.auth())
                    
                    UserDefaults.standard.removeObject(forKey: "Email")
                    UserDefaults.standard.set(phoneNumberTextField.selectedCountry?.phoneCode.appending(phoneNumber), forKey: "Phone")
                    UserDefaults.standard.synchronize()
                    let str  = phoneNumber.components(separatedBy: .whitespaces).joined()
                    if let mobileNo = phoneNumberTextField.selectedCountry?.phoneCode.appending(" " + str) {
                        print(mobileNo)
                        
                        PhoneAuthProvider.provider().verifyPhoneNumber(mobileNo, uiDelegate: nil) { verificationId, error in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            } else {
                                print(verificationId)
                                UserDefaults.standard.set(verificationId, forKey: "authVerificationID")
                                UserDefaults.standard.synchronize()
//                                self.view.makeToast("Enter Otp...", duration: 3.0, position: .bottom)
                                
                                self.hud.indicatorView = JGProgressHUDImageIndicatorView(image: UIImage(named: "about_selfstylo_logo_app")!)
                                self.hud.progress = 3.0
                                self.hud.show(in: self.view)
                                self.hud.dismiss(afterDelay: 3.0)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                                        self.performSegue(withIdentifier: "moveToOtp", sender: self)
                                    }
                              
                                
                            }
                            
                        }
                    }
                }
            } else {
                // email
                if txtEmailAddress.text == "" {
                    lblInvalidEmail.text = "Please enter valid email address"
                    lblInvalidPhone.text = ""
                }else {
                    txtPhoneNumber.text = ""
                    
                    let patron = Patron(email: txtEmailAddress.text!)
                    let trimmed = patron.email.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    apiUtils.sendEmailOtp(email: trimmed, success: { (data, response, error) in
                        DispatchQueue.main.async{
                            if let json = (try? JSONSerialization.jsonObject(with: data!)) as? [String:Any]{
                                let result = json["status"] as? String
                                if (result == "Success") {
                                    let passValue = json
                                    UserDefaults.standard.removeObject(forKey: "Phone")
                                    UserDefaults.standard.set(trimmed, forKey: "Email")
                                    UserDefaults.standard.synchronize()
                                    self.hud.indicatorView = JGProgressHUDImageIndicatorView(image: UIImage(named: "about_selfstylo_logo_app")!)
                                    self.hud.progress = 3.0
                                    self.hud.show(in: self.view)
                                    self.hud.dismiss(afterDelay: 3.0)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                                        self.performSegue(withIdentifier: "moveToOtp", sender: self)
                                    }
                                    
                                } else{
                                    let alert = UIAlertController(title: "", message: "Invalid Email Address", preferredStyle: .alert)
                                    let btnOk = UIAlertAction(title: "Okay", style: .default)
                                    alert.addAction(btnOk)
                                    self.present(alert, animated: true)
                                }
                            }
                        }
                    })
                    
                }
            }
        
            
    }
    
    
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.EmailIdView.isHidden = true
            self.PhoneView.isHidden = false
        }else
        {
            self.EmailIdView.isHidden = false
            self.PhoneView.isHidden = true
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


extension SignInViewController: FPNTextFieldDelegate,SFSafariViewControllerDelegate {
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissCountries))
        
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
       // print(name, dialCode, code)
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            controller.dismiss(animated: true, completion: nil)
        }
    
    
    
    
}
