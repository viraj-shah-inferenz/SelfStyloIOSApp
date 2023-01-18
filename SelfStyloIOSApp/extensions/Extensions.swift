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

    
    func rgbToColor() -> UIColor {
      var str = self
      str.removeFirst(4)
      str.removeLast(1)
      let sepstr = str.components(separatedBy: ",")
      var red:Double = 0.0
      var green:Double = 0.0
      var blue:Double = 0.0
      red = Double(sepstr[0]) ?? 0.0
      green = Double(sepstr[1]) ?? 0.0
      blue = Double(sepstr[2]) ?? 0.0
      let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
      return color
    }
}

extension UIImageView{
    func DownloadedFrom(url: URL,contentMode mode: UIView.ContentMode = .scaleAspectFit){
        contentMode = mode
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else{return}
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
    func DownloadedFrom(link: String,contentMode mode: UIView.ContentMode = .scaleAspectFit){
        guard let url = URL(string: link) else {return}
        DownloadedFrom(url: url,contentMode: mode)
    }
}
