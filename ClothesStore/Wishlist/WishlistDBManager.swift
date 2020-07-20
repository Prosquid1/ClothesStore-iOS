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

    func deleteAll() {
        realm?.deleteAll()
    }

    func getWishListIds() -> [Int] {
        getWishList().map { $0.id }
    }

    func getWishListItemWith(productId: Int) -> Product? {
        return realm?.object(ofType: Product.self, forPrimaryKey: productId)
    }

    func getProductStockCount(productId: Int) -> Int {
        let product = getWishListItemWith(productId: productId)
        return product?.stock ?? 0
    }

    func addToWishList(it: Product) {
        try? realm?.write {
            realm?.add(it)
        }
    }

    func insertWishListProducts(it: [Product]) {
        try? realm?.write {
            realm?.add(it)
        }
    }

    func removeFromWishList(product: Product) {
        try? realm?.write {
            realm?.delete(product)
        }
    }

    func decrementProductStockCount(productId: Int) {
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
