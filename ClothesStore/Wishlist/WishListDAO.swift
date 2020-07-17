//  WishListDAO.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/17/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import RealmSwift

protocol WishListDAO {

    func deleteAll()

    func getWishListIds() -> [Int]

    func getWishListItemWith(productId: Int) -> Product

    func getProductStockCount(productId: Int) -> Int

    func addToWishList(it: Product)

    func insertWishListProducts(it: [Product])

    func removeFromWishList(productId: Int)

    func decrementProductStockCount(productId: Int)

    func getLiveWishListIds() -> [Int]

    func getWishList() -> [Product]

    func getWishListCount() -> Int
}

