//
//  Extensions.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import Foundation
import UIKit
extension String{
    
    enum ValidityType {
        case name
        case email
        case phone
    }
    
    enum Regex: String {
        case name = "^\\w{3,18}$"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,50}"
        case phone = "^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}$" //"|^(\\+\\d{1,3}( )?)?(\\d{3}[ ]?)(\\d{2}[ ]?){2}\\d{2}$"
    }
    
    func isValid(_ validityType: ValidityType) -> Bool{
        let format = "SELF MATCHES %@"
        var regex = ""
//        let newStr = self.trimmingCharacters(in: .whitespaces)
        let str = self.removingWhitespaces()
        switch validityType{
        case .name:
            regex = Regex.name.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .phone:
            regex = Regex.phone.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: str) || str.isEmpty
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

}
