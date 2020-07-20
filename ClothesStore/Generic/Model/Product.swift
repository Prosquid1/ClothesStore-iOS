//
//  Product.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import RealmSwift

class Product: Object, Codable
{
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var category: String
    @objc dynamic var price: String?
    @objc dynamic var oldPrice: String?
    @objc dynamic var stock: Int

    override class func primaryKey() -> String? {
        return "id"
    }
}
