//
//  MakeDetails.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 24/01/23.
//

import Foundation

// MARK: - MakeDetails
struct MakeDetails: Codable {
    var data: DataClass?
    var message, status: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    var makeup: [Makeup]?
    var makeupCombos: [MakeupCombo]?
    var skintones: [Skintone]?
    var undertones: [Undertone]?
    var skintonecolors: [Skintonecolor]?
    var undertonecolors: [Undertonecolor]?

    enum CodingKeys: String, CodingKey {
        case makeup
        case makeupCombos = "makeup_combos"
        case skintones, undertones, skintonecolors, undertonecolors
    }
}

// MARK: - Makeup
struct Makeup: Codable {
    var id: Int?
    var makeupName, icon: String?
    var showIndex: Int?
    var category: [Category]?

    enum CodingKeys: String, CodingKey {
        case id
        case makeupName = "makeup_name"
        case icon
        case showIndex = "show_index"
        case category
    }
}

// MARK: - Category
struct Category: Codable {
    var id: Int?
    var categoryName: String?
    var categoryIcon: String?
    var products: [Product]?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryName = "category_name"
        case categoryIcon = "category_icon"
        case products
    }
}

// MARK: - Product
struct Product: Codable {
    var id: Int?
    var productTypeCode: Int?
    var colorName, hexColorcode, colorCode: String?
    var productCode: String?
    var createDate: String?
    var categorieID: Int?
    var productType: Int?
    var productLiked: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case productTypeCode = "product_type_code"
        case colorName = "color_name"
        case hexColorcode = "hex_colorcode"
        case colorCode = "color_code"
        case productCode = "product_code"
        case createDate = "create_date"
        case categorieID = "categorie_id"
        case productType = "product_type"
        case productLiked = "product_liked"
    }
}

// MARK: - MakeupCombo
struct MakeupCombo: Codable {
    var id: Int?
    var templateName, templateIcon: String?
    var colors: [Int]?

    enum CodingKeys: String, CodingKey {
        case id
        case templateName = "template_name"
        case templateIcon = "template_icon"
        case colors
    }
}

// MARK: - Skintonecolor
struct Skintonecolor: Codable {
    var skintone: Int?
    var colors: [Int]?
}

// MARK: - Skintone
struct Skintone: Codable {
    var id: Int?
    var skintone, code: String?
}

// MARK: - Undertonecolor
struct Undertonecolor: Codable {
    var skintone, undertone: Int?
    var colors: [Int]?
}

// MARK: - Undertone
struct Undertone: Codable {
    var id: Int?
    var undertone, code: String?
}
