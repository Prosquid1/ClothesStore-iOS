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
    @objc var id: Int
    @objc var name: String
    @objc var category: String
    @objc var price: String?
    @objc var oldPrice: String?
    @objc var stock: Int
}
