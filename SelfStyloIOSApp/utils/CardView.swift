//
//  CardView.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 05/01/23.
//

import Foundation
import UIKit

@IBDesignable class CardView : UIView{
    @IBInspectable var cornerRadius : CGFloat = 5
    
    override func layoutSubviews() {
        layer.cornerRadius = self.cornerRadius
    }
}

@IBDesignable class TextFieldView : UITextField{
    @IBInspectable var cornerRadius : CGFloat = 5
    var borderWidth : CGFloat = 1
    var color: UIColor = UIColor.white
    
    override func layoutSubviews() {
        layer.cornerRadius = self.cornerRadius
        layer.borderWidth = self.borderWidth
        layer.backgroundColor = self.color.cgColor
        layer.borderColor = UIColorFromHex(rgbValue: 0xDDDFEC, alpha: 0.7).cgColor
        
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0

        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}
