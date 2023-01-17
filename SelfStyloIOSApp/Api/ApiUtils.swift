//
//  ApiUtils.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 12/01/23.
//

import Foundation
import UIKit

protocol GetUsersDelegate {
    func refreshFavouriteProductsList(favouriteproductList: [FavouriteProducts])
}
class ApiUtils{
    var getUserDelegate: GetUsersDelegate?
    var apiCalls = IApiCalls()
    
    private let DOMAIN_URL = "https://dev.selfstylo.com/"
    
    init()
        {
            
        }

    
    
    func getFavouriteProductDetail(){
//           if(isInternetAvailable()){
               let serviceUrl = DOMAIN_URL + apiCalls.get_favourite_product + "?id="
           let url = URL(string: serviceUrl)
           
           if let url = url {
               
               let session = URLSession(configuration: .default)
               
               let task = session.dataTask(with: url,completionHandler: {
                   (data, response, error) in
                   if error == nil{
                       self.parseFavouriteProductDataIntoDb(data: data!)
                   }else{
                       
                   }
               })
               
               task.resume()
            }
        //   }
       }
       
       func parseFavouriteProductDataIntoDb(data: Data) {
           var userList: [FavouriteProducts] = []
           let db1 = FavouriteProductDao()
           
           do{
               let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

              // if let dictionary = json as? [String: Any]
              if let dictionary = json as? Array<Dictionary<String, Any>>
               {
                   for i in dictionary {
                       let user = FavouriteProducts()
                           user.product_id = i["id"] as! Int
                           user.subCategoryName = i["subcategory"] as! String
                           user.categoryName = i["category"] as! String
                           user.colorName = i["color_name"] as! String
                           user.colorCode = i["color_code"] as! String
                           user.brandName = i["company_name"] as! String
                           user.brandLogoUrl = i["brand_logo"] as! String
                           userList.append(user)
                        //   db1.deleteByID()
                           db1.insert(userList: user)
                   }
                 
                   print("USERS : ", userList)
                  DispatchQueue.main.async {
                      self.getUserDelegate?.refreshFavouriteProductsList(favouriteproductList: userList)
                      
                  }
               }

           }catch{
               print("Error : ", error.localizedDescription)
           }
       }
    
    func sendEmailOtp(email:String){
        let serviceUrl = DOMAIN_URL + apiCalls.sendEmailOtp
        var request = URLRequest(url: URL(string: serviceUrl)!)
            request.httpMethod = "POST"
            let postString = "email=\(email)"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("error=(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        }
    
    func sendVerifyOtp(email:String,otp:String){
        let serviceUrl = DOMAIN_URL + apiCalls.sendVerifyOtp
        var request = URLRequest(url: URL(string: serviceUrl)!)
            request.httpMethod = "POST"
            let postString = "email=\(email)&otp=\(otp)"
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("error=(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        }
    
    
    func updateUserDetails(patron:Patron){
        let serviceUrl = DOMAIN_URL + apiCalls.updateUserData
        var request = URLRequest(url: URL(string: serviceUrl)!)
            request.httpMethod = "POST"
        let postString1 = "name=\(patron.name)&email=\(patron.email)&contact_number=\(patron.phoneNumber)&gender=\(patron.gender)"
            request.httpBody = postString1.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) {
                   data, response, error in
                  guard let data = data, error == nil else {
                    print("error=(error)")
                    return
                }
                   
                   if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                       print("statusCode should be 200, but is \(httpStatus.statusCode)")
                       print("response = \(String(describing: response))")
                       
                   }
                
                       let responseString = String(data: data, encoding: .utf8)
                        print("responseString = \(String(describing: responseString))")
                       self.parseUserDataIntoDb(data: data)
               }
               
               task.resume()
        
       }
       
       func parseUserDataIntoDb(data: Data) {
           var userList: [Patron] = []
           let db1 = PatronDao()
           
           do{
               let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

              // if let dictionary = json as? [String: Any]
              if let dictionary = json as? Array<Dictionary<String, Any>>
               {
                   for i in dictionary {
                       let user = Patron()
                       user.id = i["id"] as! Int
                           user.name = i["name"] as! String
                           user.email = i["email"] as! String
                           user.phoneNumber = i["contact_number"] as! String
                           user.gender = i["gender"] as! String
                           userList.append(user)
                        //   db1.deleteByID()
                           db1.insert(userList: user)
                   }
                 
                   print("USERS : ", userList)
               }

           }catch{
               print("Error : ", error.localizedDescription)
           }
       }
        
}


