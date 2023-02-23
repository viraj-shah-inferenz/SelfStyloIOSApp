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
