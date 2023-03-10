//
//  Extensions.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 03/01/23.
//

import Foundation
import UIKit


enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    func base64(format: ImageFormat) -> String? {
        var imageData: Data?
        
        switch format {
        case .png: imageData = self.pngData()
        case .jpeg(let compression): imageData = self.jpegData(compressionQuality: compression)
        }
        
        return imageData?.base64EncodedString()
    }
}

extension String{
    
    enum ValidityType {
        case name
        case email
        case phone
    }
    
    enum Regex: String {
        case name = "^\\w{3,18}$"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,50}"
        case phone = "^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}$"
    }
    
    func isValid(_ validityType: ValidityType) -> Bool{
        let format = "SELF MATCHES %@"
        var regex = ""
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
    
    func imageFromBase64() -> UIImage? {
        guard let data = Data(base64Encoded: self) else { return nil }
        
        return UIImage(data: data)
    }
    
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
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
            DispatchQueue.main.sync {
                self.image = image
            }
        }.resume()
    }
    
    func DownloadedFrom(link: String,contentMode mode: UIView.ContentMode = .scaleAspectFit){
        guard let url = URL(string: link) else {return}
        DownloadedFrom(url: url,contentMode: mode)
    }
}

extension UIApplication {

    func getKeyWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            return windows.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }

    func makeSnapshot() -> UIImage? { return getKeyWindow()?.layer.makeSnapshot() }
}


extension CALayer {
    func makeSnapshot() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}

extension UIView {
    func makeSnapshot() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: frame.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
        } else {
            return layer.makeSnapshot()
        }
    }
}

extension UIImage {
    convenience init?(snapshotOf view: UIView) {
        guard let image = view.makeSnapshot(), let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0,0,0,0)
    }
    // hue, saturation, brightness and alpha components from UIColor**
    var hsbComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
            return (hue,saturation,brightness,alpha)
        }
        return (0,0,0,0)
    }
    var htmlRGBColor:String {
        return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
    }
    var htmlRGBaColor:String {
        return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255),Int(rgbComponents.alpha * 255) )
    }
}
