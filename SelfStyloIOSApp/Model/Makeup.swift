//
//  Makeup.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 25/01/23.
//



// MARK: - Welcome8
struct Welcome8 {
    let data: DataClass
    let message, status: String
}

// MARK: - DataClass
struct DataClass {
    let makeup: [Makeup]
    let makeupCombos: [MakeupCombo]
    let skintones: [Skintone]
    let undertones: [Undertone]
    let skintonecolors: [Skintonecolor]
    let undertonecolors: [Undertonecolor]
}

// MARK: - Makeup
struct Makeup {
    let id: Int
    let makeupName, icon: String
    let showIndex: Int
    let category: [Category]
}

// MARK: - Category
struct Category {
    let id: Int
    let categoryName: String
    let categoryIcon: String?
    let products: [Product]
}

// MARK: - Product
struct Product {
    let id: Int
    let productTypeCode: Int?
    let colorName, hexColorcode, colorCode: String
    let productCode: String?
    let createDate: String
    let categorieID: Int
    let productType: Int?
    let productLiked: Bool
}

// MARK: - MakeupCombo
struct MakeupCombo {
    let id: Int
    let templateName, templateIcon: String
    let colors: [Int]
}

// MARK: - Skintonecolor
struct Skintonecolor {
    let skintone: Int
    let colors: [Int]
}

// MARK: - Skintone
struct Skintone {
    let id: Int
    let skintone, code: String
}

// MARK: - Undertonecolor
struct Undertonecolor {
    let skintone, undertone: Int
    let colors: [Int]
}

// MARK: - Undertone
struct Undertone {
    let id: Int
    let undertone, code: String
}

