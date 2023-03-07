//
//  SkintoneUndertone.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 06/03/23.
//

import Foundation

// MARK: - SkintoneUndertone
struct SkintoneUndertone: Codable {
    let data: SkintoneUndertoneData?
    let message, status: String?
}

// MARK: - DataClass
struct SkintoneUndertoneData: Codable {
    let skintones: [Skintone]?
    let undertones: [Undertone]?
}

// MARK: - Skintone
struct Skintone: Codable {
    let id: Int?
    let skintone, code: String?
}

// MARK: - Undertone
struct Undertone: Codable {
    let id: Int?
    let undertone, code: String?
}
