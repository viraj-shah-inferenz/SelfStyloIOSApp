//
//  EyelinerData.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 09/02/23.
//

import Foundation
// MARK: - EyelinerData
struct EyelinerModel: Codable {
    let data: [EyelinerData]?
    let message, status: String?
}

// MARK: - Datum
struct EyelinerData: Codable {
    let id: Int?
    let isActive: Bool?
    let eyelinerStyleName, eyelinerStyleImage, eyelinerStyleIcon, eyelinerSVGString: String?
    let companyID: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case isActive = "is_active"
        case eyelinerStyleName = "eyeliner_style_name"
        case eyelinerStyleImage = "eyeliner_style_image"
        case eyelinerStyleIcon = "eyeliner_style_icon"
        case eyelinerSVGString = "eyeliner_svg_string"
        case companyID = "company_id"
    }
}
