//
//  SignInPhoneOtpViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 06/01/23.
//

import UIKit
import OTPFieldView
import FirebaseAuth
import GoogleSignIn

import Toast_Swift

class SignInOtpViewController: UIViewController {

    @IBOutlet var otpTextFieldView: OTPFieldView!
    
    @IBOutlet weak var LblEmail: UILabel!
    
    @IBOutlet weak var LblPhone: UILabel!
    
    var apiUtils = ApiUtils()
    var emailVC = SignInEmailViewController()
    var phoneVC = SignInPhoneViewController()
    var otpString:String = ""
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
  
    @IBOutlet weak var resendBtn: UIButton!
    
    
    
    @IBOutlet weak var resendOTPBtn: UIButton!
    
    let userDefault = UserDefaults.standard
    var patron = Patron()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = ""
        sendOTPCode()
        setupOtpView()
        getUserData()
        setbtnProceedView(toView: resendOTPBtn)
      
    }
    func getUserData(){
        if let email = userDefault.string(forKey: "Email")
        {
            if email == ""
            {
                LblEmail.text = ""
            }else
            {
                LblEmail.text = email
            }
        }
           
        if let phone = userDefault.string(forKey: "Phone")
        {
            if phone == ""
            {
                LblPhone.text = ""
            }else
            {
                LblPhone.text = phone
            }
        }
    }
    
    
    @IBAction func resendOTPCode(_ sender: UIButton) {
        let email = userDefault.string(forKey: "Email")
        if email == "" {
            let patron = Patron(email: email!)
            apiUtils.sendEmailOtp(email: patron.email)
            timerLabel.text = ""
            totalTime = 31
            resendOTPBtn.isEnabled = false
            resendBtn.isHidden = true
            sendOTPCode()
        }
        
    }
    
    func setupOtpView(){
            self.otpTextFieldView.layer.cornerRadius = 18
            self.otpTextFieldView.layer.borderWidth = 1
            self.otpTextFieldView.layer.borderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7).cgColor
            self.otpTextFieldView.fieldsCount = 6
            self.otpTextFieldView.fieldBorderWidth = 2
            self.otpTextFieldView.filledBorderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7)
            self.otpTextFieldView.displayType = .underlinedBottom
            self.otpTextFieldView.fieldSize = 40
            self.otpTextFieldView.separatorSpace = 8
            self.otpTextFieldView.shouldAllowIntermediateEditing = false
            self.otpTextFieldView.delegate = self
            self.otpTextFieldView.initializeUI()
            
        }

    
    
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    @IBAction func backSignIn(_ sender: UIButton) {
        let detailViewController:UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        
        detailViewController.modalPresentationStyle = .fullScreen
        self.present(detailViewController, animated: false)
    }
    
    @IBAction func resendOTPBtnClicked(_ sender: UIButton) {
        UserDefaults.standard.set("true", forKey: APP.IS_LOGIN)
        UserDefaults.standard.synchronize()
        if let email = emailVC.txtEmailAddress?.text {
            if email != "" {
                let patron = Patron(email: emailVC.txtEmailAddress.text!)
                apiUtils.sendVerifyOtp(email: patron.email,otp: otpString)
                timerLabel.text = ""
                totalTime = 31
                resendOTPBtn.isEnabled = false
                sendOTPCode()
            }else{
                print("Please enter valid OTP")
            }
        }
        
      
        
        guard let verificationId = UserDefaults.standard.string(forKey: "authVerificationID") else {return}
        print(verificationId)
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpString)
        
        Auth.auth().signIn(with: credential){ (success, error) in
            
            if error == nil{
                print(success)
                
                self.view.makeToast("Sign in successfully...", duration: 3.0, position: .bottom)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                    let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInProfileViewController") as! SignInProfileViewController
                    self.navigationController?.pushViewController(profileVC, animated: true)
                }
                
            } else {
                if let err = error {
//                    self.view.makeToast("\(err.localizedDescription)", duration: 3.0, position: .bottom)
                    let alert = UIAlertController(title: "Error", message: "Invalid OTP, please provide the correct OTP", preferredStyle: .alert)
                    let btnOk = UIAlertAction(title: "Okay", style: .default)
                    alert.addAction(btnOk)
                    self.present(alert, animated: true)
                    
                }
                
            
            }
            
            
        }
        
    }
    var countdownTimer: Timer!
        var totalTime = 60
    
    
    
    @objc func updateTimerLabel() {
           totalTime -= 1
           timerLabel.text = "\(timeFormatted(totalTime))"
          if totalTime == 0 {
              timerLabel.text = ""
              resendBtn.isHidden = false
              countdownTimer.invalidate()
              resendOTPBtn.isEnabled = true
          }

        }
    
    
    func sendOTPCode() {
              self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
               let seconds: Int = totalSeconds % 60
               let minutes: Int = (totalSeconds / 60) % 60
               //     let hours: Int = totalSeconds / 3600
               return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setbtnProceedView(toView: UIButton)
    {
        toView.layer.cornerRadius = 20
    }
}



extension SignInOtpViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
      //  print("Has entered all OTP? \(hasEntered)")
        if hasEntered{
            resendOTPBtn.isEnabled = true
            resendOTPBtn.backgroundColor = UIColorFromHex(rgbValue: 0x181A24)
            resendOTPBtn.setTitleColor(UIColor.white, for: .normal)
        }else
        {
            resendOTPBtn.isEnabled = false
            resendOTPBtn.backgroundColor = UIColor.darkGray
        }
        return false
    }
    
   
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
        
    }
    
    func enteredOTP(otp otpString: String) {
      self.otpString = otpString
    }
}
