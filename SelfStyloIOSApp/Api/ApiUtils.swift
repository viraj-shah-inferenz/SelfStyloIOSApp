//
//  ApiUtils.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 12/01/23.
//

import Foundation
import UIKit
import Reachability

struct APP {
    static let IS_LOGIN = "isLogin"
    static let EYELINER_STYLE = "eyelinerStyle"
    static let EYELINER_STYLE_Id = "eyelinerStyleId"
}

protocol GetUsersDelegate {
//    func refreshFavouriteProductsList(favouriteproductList: [FavouriteProducts])
    func refreshBannerList(bannerList: [Banner])
}

class ApiUtils {
    var getUserDelegate: GetUsersDelegate?
    var apiCalls = IApiCalls()
    
    static let DOMAIN_URL = "https://dev.selfstylo.com/"
    static let MAKEUP_URL = "https://makeup.selfstylo.com/"
    static let RECODE_URL = "https://recode.selfstylo.com/"
    let reachability = try! Reachability()
    
    init()
    {
        
    }
    
    
    func sendEmailOtp(email:String,success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void){
       
        if reachability.connection == .wifi || reachability.connection == .cellular {
            let serviceUrl = ApiUtils.MAKEUP_URL + self.apiCalls.sendEmailOtp
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
                
                success(data,response as? HTTPURLResponse,error as NSError?)
            }
            task.resume()
        }else {
                print("Not reachable")
            
        }

    }
    
    func sendVerifyOtp(email:String,otp:String){
            if reachability.connection == .wifi || reachability.connection == .cellular{
                let serviceUrl = ApiUtils.MAKEUP_URL + self.apiCalls.sendVerifyOtp
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
            else {
                    print("Not reachable")
            }
        
    }
    
    
    func updateUserDetails(patron:Patron) -> Bool{
            if reachability.connection == .wifi || reachability.connection == .cellular {
                let serviceUrl = ApiUtils.DOMAIN_URL + self.apiCalls.updateUserData
                let db1 = PatronDao()
                db1.deleteAll()
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
                    db1.insert(userList: patron)
                    self.parseUserDataIntoDb(data: data)
                }
                
                
                task.resume()
            }
            else {
                reachability.whenUnreachable = { _ in
                    print("Not reachable")
                }
            }
        return true
        
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
                    //db1.deleteAll()
                    db1.insert(userList: user)
                }
                
                print("USERS : ", userList)
            }
            
        }catch{
            print("Error : ", error.localizedDescription)
        }
    }
    
    func getBanner(){
            if reachability.connection == .wifi   ||  reachability.connection == .cellular {
                let serviceUrl = ApiUtils.DOMAIN_URL + self.apiCalls.getBanner
                let url = URL(string: serviceUrl)
                
                if let url = url {
                    
                    let session = URLSession(configuration: .default)
                    
                    DispatchQueue.global(qos: .userInteractive).async {
                        let task = session.dataTask(with: url,completionHandler: {
                            (data, response, error) in
                            if error == nil{
                                DispatchQueue.main.async {
                                    self.parseBannerDataIntoDb(data: data!)
                                }
                            }else{
                                
                            }
                        })
                        task.resume()
                    }
                    
                }
            }else {
                    print("Not reachable")
                
            }
        
    }
    
    func parseBannerDataIntoDb(data: Data) {
        var userList: [Banner] = []
        let db1 = BannerDao()
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            // if let dictionary = json as? [String: Any]
            if let dictionary = json as? Array<Dictionary<String, Any>>
            {
                for i in dictionary {
                    let user = Banner()
                    user.id = i["id"] as! Int
                    user.upload_image = i["upload_image"] as! String
                    user.is_active = i["is_active"] as! Bool
                    userList.append(user)
                    db1.insert(userList: user)
                }
                
                print("USERS : ", userList)
                self.getUserDelegate?.refreshBannerList(bannerList: userList)
            }
            
        }catch{
            print("Error : ", error.localizedDescription)
        }
    }
    
    
    /*func getFavouriteProductDetail(){
            if reachability.connection == .wifi || reachability.connection == .cellular
            {
                let serviceUrl = ApiUtils.DOMAIN_URL + self.apiCalls.get_favourite_product + "?id=4aa6223c-8439-4ed3-8de0-f6a67b1d36bd"
                let url = URL(string: serviceUrl)
                
                if let url = url {
                    
                    let session = URLSession(configuration: .default)
                    DispatchQueue.global(qos: .userInteractive).async {
                        let task = session.dataTask(with: url,completionHandler: {
                            (data, response, error) in
                            if error == nil{
                                if let httpResponse = response as? HTTPURLResponse{
                                    if httpResponse.statusCode == 404{
                                        print("There is some problem with server connection, please try again")
                                        return
                                    } else if httpResponse.statusCode == 500 {
                                        print("Internal Server Error, please try again")
                                        return
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    self.parseFavouriteProductDataIntoDb(data: data!)
                                }
                            }else{
                                
                            }
                        })
                        
                        task.resume()
                    }
                }
            }else
            {
               
                    print("Not reachable")
            }
        
    }*/
    
    /*func parseFavouriteProductDataIntoDb(data: Data) {
        var userList: [FavouriteProducts] = []
        let db1 = FavouriteProductDao()
        
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        
        // if let dictionary = json as? [String: Any]
        if let data = json?["data"] as? [Any]
        {
            for item in data{
                if let object = item as? [String:Any]
                {
                    let user = FavouriteProducts()
                    user.product_id = object["id"] as! Int
                    user.subCategoryName = object["subcategory"] as! String
                    user.categoryName = object["category"] as! String
                    user.colorName = object["color_name"] as! String
                    user.colorCode = object["color_code"] as! String
                    user.brandName = object["company_name"] as! String
                    user.brandLogoUrl = object["brand_logo"] as! String
                    userList.append(user)
                    //db1.deleteAll()
                    db1.insert(userList: user)
                    
                    print("USERS : ", userList)
                    self.getUserDelegate?.refreshFavouriteProductsList(favouriteproductList: userList)
                }
            }
        }
    }*/
    
    func getUserDetail(id:String) -> Bool{
            if reachability.connection == .wifi || reachability.connection == .cellular
            {
                let serviceUrl = ApiUtils.DOMAIN_URL + self.apiCalls.existingUserData + "?id=\(id)"
                let url = URL(string: serviceUrl)
                
                if let url = url {
                    
                    let session = URLSession(configuration: .default)
                    
                    let task = session.dataTask(with: url,completionHandler: {
                        (data, response, error) in
                        if error == nil{
                            self.parseUserDetailIntoDb(data: data!)
                        }else{
                            
                        }
                    })
                    
                    task.resume()
                }
            }else
            {
                    print("Not reachable")
                
            }
        
        return true
    }
    
    func parseUserDetailIntoDb(data: Data) {
        var userList: [Patron] = []
        let db1 = PatronDao()
        if let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]{
            let user = Patron()
            user.id = json["id"] as? Int ?? 0
            user.name = json["name"] as? String ?? "N/A"
            user.email = json["email"] as? String ?? "N/A"
            user.phoneNumber = json["contact_number"] as? String ?? "N/A"
            user.gender = json["gender"] as? String ?? "N/A"
            user.profileImage = json["display_picture"] as? String ?? "N/A"
            userList.append(user)
            //db1.deleteAll()
            db1.insert(userList: user)
            print("USERS : ", userList)
        }
    }
    
    func fetchMakeupDetails(sc: @escaping (MakeDetails?)->Void) {
        if reachability.connection == .wifi || reachability.connection == .cellular
        {
            let uuid = "4aa6223c-8439-4ed3-8de0-f6a67b1d36bd" //UUID().uuidString
            let serviceUrl = ApiUtils.MAKEUP_URL + apiCalls.makeupDetails + "?uuid=\(uuid)"
            var request = URLRequest(url: URL(string: serviceUrl)!)
            request.timeoutInterval = 50
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let makeupDetails = try? JSONDecoder().decode(MakeDetails.self, from: data) {
                        sc(makeupDetails)
                        //print(makeupDetails.data?.makeup?[0].makeupName)
                    } else {
                        print("Invalid Response")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }.resume()
        }else
        {
            print("Not reachable")
            
        }
           
    }
    
    func fetchEyelinerStyles(model: @escaping (EyelinerModel?) -> Void) {
//        api/eyeliner-style/
        let serviceUrl = ApiUtils.MAKEUP_URL + apiCalls.eyelinerStyle // + "?uuid=\(10)"
        
        var request = URLRequest(url: URL(string: serviceUrl)!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let eyelinerModel = try? JSONDecoder().decode(EyelinerModel.self, from: data) {
//                    print(eyelinerModel.data?[0].eyelinerStyleImage)
                    model(eyelinerModel)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }.resume()
    }
    
//    SkintoneUndertone
    func getUndertoneSkintone(fronUrl urlStr: String, completionHandler: @escaping (Result<Data, Error>) -> Void ) {
        if reachability.connection == .wifi || reachability.connection == .cellular {
            let session = URLSession(configuration: .default)
            guard let url = URL(string: urlStr) else { return }
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 300.0)
            request.httpMethod = "GET"
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let err = error {
                    completionHandler( .failure(err.localizedDescription as! Error))
                } else {
                    if let dt = data {
                        completionHandler( .success(dt))
                    } else {
                        completionHandler( .failure("Error in parsing data" as! Error))
                    }
                }
            }
            dataTask.resume()
        } else {
            
            completionHandler(.failure("No internet" as! Error))
        }
        
    }
    
    func makeRequest(fronUrl urlStr: String, completionHandler: @escaping (Result<Data, Error>) -> Void ) {
        if reachability.connection == .wifi || reachability.connection == .cellular {
            let session = URLSession(configuration: .default)
            guard let url = URL(string: urlStr) else { return }
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 300.0)
            request.httpMethod = "GET"
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let err = error {
                    completionHandler( .failure(err.localizedDescription as! Error))
                } else {
                    if let dt = data {
                        completionHandler( .success(dt))
                    } else {
                        completionHandler( .failure("Error in parsing data" as! Error))
                    }
                }
            }
            dataTask.resume()
        } else {
            
            completionHandler(.failure("No internet" as! Error))
        }
        
    }
}
