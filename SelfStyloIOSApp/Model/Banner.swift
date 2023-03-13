//
//  Banner.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 17/01/23.
//

import Foundation
class Banner: Codable {
    let id: Int
    let uploadImage: String
    let isActive: Bool
    let companyID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case uploadImage = "upload_image"
        case isActive = "is_active"
        case companyID = "company_id"
    }
    
    init?(){
        return nil
    }

    init(id: Int, uploadImage: String, isActive: Bool, companyID: Int) {
        self.id = id
        self.uploadImage = uploadImage
        self.isActive = isActive
        self.companyID = companyID
    }
}
