//
//  MakeupUpdate.swift
//  SelfStyloIOSApp
//
//  Created by Abhishek Dudhrejia on 03/02/23.
//

import Foundation

// MARK: - EffectData
class EffectData: Codable {
    let effectData: EffectDataClass

    init(effectData: EffectDataClass) {
        self.effectData = effectData
    }
}

// MARK: - EffectDataClass
class EffectDataClass: Codable {
    let lipstick, eyeshadow: MakeupData
    
    enum CodingKeys: String, CodingKey {
        case lipstick = "Lipstick"
        case eyeshadow = "Eyeshadow"
    }

    init(lipstick: MakeupData, eyeshadow: MakeupData) {
        self.lipstick = lipstick
        self.eyeshadow = eyeshadow
    }
}

// MARK: - Eyeshadow
class MakeupData: Codable {
    let color: [Int]
    let productType: Int

    init(color: [Int], productType: Int) {
        self.color = color
        self.productType = productType
    }
}

extension Encodable {
    var convertToString: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
