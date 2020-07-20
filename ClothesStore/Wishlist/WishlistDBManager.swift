//
//  WishlistDBManager.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/17/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import RealmSwift

private let realm = try? Realm()

class WishlistDBManager: WishListDAO {
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
        realm?.add(it)
    }

    func insertWishListProducts(it: [Product]) {
        realm?.add(it)
    }

    func removeFromWishList(productId: Int) {
        let product = getWishListItemWith(productId: productId)
        if let safeProduct = product {
            realm?.delete(safeProduct)
        }
    }

    func decrementProductStockCount(productId: Int) {
        let product = getWishListItemWith(productId: productId)
        if let safeProduct = product {
            realm?.delete(safeProduct)
        }
    }

    func getLiveWishListIds() -> [Int] {
        return []
    }

    func getWishList() -> [Product] {
        realm?.objects(Product.self).toArray() ?? []
    }

    func getWishListCount() -> Int {
        realm?.objects(Product.self).count ?? 0
    }


}
