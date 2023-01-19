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

class SignInOtpViewController: UIViewController {

    @IBOutlet var otpTextFieldView: OTPFieldView!
    var apiUtils = ApiUtils()
    var emailVC = SignInEmailViewController()
    var phoneVC = SignInPhoneViewController()
    var otpString:String = ""
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var resendOTPBtn: UIButton!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = ""
        sendOTPCode()
        setupOtpView()
    
        // Do any additional setup after loading the view.
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
        
        guard let verificationId = userDefault.string(forKey: "verificationId") else {return}
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otpString)
        Auth.auth().signIn(with: credential){ (success, error) in
            if error == nil{
                print(success)
                print("User Signed In...")
            }else
            {
                print("Something went wrong...\(error?.localizedDescription)")
            }
        }
        
    }
    var countdownTimer: Timer!
        var totalTime = 30
    
    
    
    @objc func updateTimerLabel() {
           totalTime -= 1
           timerLabel.text = "\(timeFormatted(totalTime))"
          if totalTime == 0 {
              timerLabel.text = ""
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
}



extension SignInOtpViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        self.otpString = otpString
    }
}
