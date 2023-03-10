//
//  LikeProductList.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 09/03/23.
//

import Foundation

// MARK: - ProductList
struct FavouriteProducts: Codable {
    let data: [FavouriteProductData]?
    let message, status: String?
}

// MARK: - Datum
struct FavouriteProductData: Codable {
    let id: Int?
    let companyName: String?
    let category: String?
    let subcategory, colorName, colorCode, brandLogo: String?

    enum CodingKeys: String, CodingKey {
        case id
        case companyName = "company_name"
        case category = "category"
        case subcategory = "subcategory"
        case colorName = "color_name"
        case colorCode = "color_code"
        case brandLogo = "brand_logo"
    }
}
