//
//  Product.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Unrealm

struct Product: Realmable, Codable
{
    var id: Int = 0
    var name: String = ""
    var category: String = ""
    var price: String? = ""
    var oldPrice: String? = ""
    var stock: Int = 0

    static func primaryKey() -> String? {
        return "id"
    }
}
