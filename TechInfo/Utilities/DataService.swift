//
//  DataService.swift
//  TechInfo
//
//  Created by Adel on 24/07/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation
class DataService {
    static let instance = DataService()
    
    private let categories = [
        Category(title: "FACTURE", imageName: "calculator-desk-finance-1253591.jpg"),
        Category(title: "DEVIS", imageName: "DEVIS.png"),
        Category(title: "NOTE DE FRAIS", imageName: "FJHLQRN4S34NXBMCV2MVCZOQ3I.jpg")

    ]
    
    func getCategories() -> [Category] {
        return categories
    }
}
