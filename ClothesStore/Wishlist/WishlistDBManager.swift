//
//  WishlistDBManager.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/17/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import RealmSwift

class WishlistDBManager: WishListDAO {
    private let realm = try? Realm()

    func addToWishList(it: Product) {
        try? realm?.write {
            realm?.create(Product.self, value: it, update: .all)
        }
    }

    func deleteAll() {
        try? realm?.write {
            realm?.deleteAll()
        }
    }

    func getWishListIds() -> [Int] {
        getWishList().map { $0.id }
    }

    func getWishListItemWith(productId: Int) -> Product? {
        return realm?.object(ofType: Product.self, forPrimaryKey: productId)
    }

    func removeFromWishList(productId: Int) {
        try? realm?.write {
            let product = getWishListItemWith(productId: productId)
            if let safeProduct = product {
                realm?.delete(safeProduct)
            }

        }
    }

    func getWishList() -> [Product] {
        realm?.objects(Product.self).toArray() ?? []
    }

    func getWishListCount() -> Int {
        realm?.objects(Product.self).count ?? 0
    }

}
