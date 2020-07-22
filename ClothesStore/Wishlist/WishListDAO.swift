//  WishListDAO.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/17/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import RealmSwift

protocol WishListDAO {

    func addToWishList(it: Product)

    func deleteAll()

    func getWishList() -> [Product]

    func getWishListIds() -> [Int]

    func getWishListItemWith(productId: Int) -> Product?

    func removeFromWishList(productId: Int)

}

