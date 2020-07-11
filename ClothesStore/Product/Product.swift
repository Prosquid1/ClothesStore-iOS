//
//  Product.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class Product: Codable {
    var id: Int
    var name: String
    var category: String
    var price: String?
    var oldPrice: String?
    var stock: Int
}
