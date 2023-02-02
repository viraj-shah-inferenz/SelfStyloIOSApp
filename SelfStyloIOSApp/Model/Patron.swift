//
//  Patron.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 13/01/23.
//

import Foundation

class Patron:Decodable{
       var id: Int = 0
       var email: String = ""
       var phoneNumber: String = ""
       var name: String = ""
       var gender: String = "";
       var profileImage: String = "";
       var uuid: String = "";
    
    init(){
        
    }
    
    init(id:Int,email:String, phoneNumber: String, name:String,gender:String,profileImage:String,uuid:String) {
           self.id = id
           self.email = email
           self.phoneNumber = phoneNumber
           self.name = name
           self.gender = gender
           self.profileImage = profileImage
           self.uuid = uuid
       }
    
    init(email:String, phoneNumber: String, name:String,gender:String,profileImage:String) {
           self.email = email
           self.phoneNumber = phoneNumber
           self.name = name
           self.gender = gender
           self.profileImage = profileImage
       }

    init(email:String) {
           self.email = email
       }

    init(email:String,phoneNumber:String) {
           self.email = email
           self.phoneNumber = phoneNumber
       }
    
    
}
