//
//  SignInPhoneOtpViewController.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 06/01/23.
//

import UIKit
import OTPFieldView

class SignInOtpViewController: UIViewController {

    @IBOutlet var otpTextFieldView: OTPFieldView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOtpView()
        // Do any additional setup after loading the view.
    }
    
    
    func setupOtpView(){
            self.otpTextFieldView.layer.cornerRadius = 18
            self.otpTextFieldView.layer.borderWidth = 1
            self.otpTextFieldView.layer.borderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7).cgColor
            self.otpTextFieldView.fieldsCount = 5
            self.otpTextFieldView.fieldBorderWidth = 2
            self.otpTextFieldView.filledBorderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7)
            self.otpTextFieldView.cursorColor = UIColor.black
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
    }
}
