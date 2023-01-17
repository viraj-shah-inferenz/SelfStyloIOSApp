//
//  Banner.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 17/01/23.
//

import Foundation
class Banner:Decodable{
       var id: Int = 0
       var upload_image: String = ""
       var is_active: Bool = true
    
    init(){
        
    }
    
    init(id:Int, upload_image:String,is_active:Bool)
    {
        self.id = id
        self.upload_image = upload_image
        self.is_active = is_active
    }
    
    
}
