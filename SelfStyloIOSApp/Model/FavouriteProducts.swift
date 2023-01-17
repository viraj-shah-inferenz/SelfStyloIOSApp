//
//  FavouriteProducts.swift
//  SelfStyloIOSApp
//
//  Created by Viraj Shah on 12/01/23.
//

import Foundation
class FavouriteProducts:Decodable{
    var product_id: Int = 0
    var subCategoryName: String = ""
    var categoryName: String = ""
    var colorName: String = ""
    var colorCode: String = ""
    var brandName: String = ""
    var brandLogoUrl: String = ""
    
    init(){
        
    }
    
    init(product_id: Int, subCategoryName: String, categoryName: String, colorName: String, colorCode: String, brandName: String, brandLogoUrl: String) {
        self.product_id = product_id
        self.subCategoryName = subCategoryName
        self.categoryName = categoryName
        self.colorName = colorName
        self.colorCode = colorCode
        self.brandName = brandName
        self.brandLogoUrl = brandLogoUrl
    }
    
    
}

