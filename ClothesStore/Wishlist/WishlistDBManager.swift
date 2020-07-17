//
//  WishlistDBManager.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/17/20.
//  Copyright © 2020 Personal. All rights reserved.
//

class WishlistDBManager: WishListDAO {
    func deleteAll() {
        <#code#>
    }

    func getWishListIds() -> [Int] {
        <#code#>
    }

    func getWishListItemWith(productId: Int) -> Product {
        <#code#>
    }

    func getProductStockCount(productId: Int) -> Int {
        <#code#>
    }

    func addToWishList(it: Product) {
        <#code#>
    }

    func insertWishListProducts(it: [Product]) {
        <#code#>
    }

    func removeFromWishList(productId: Int) {
        <#code#>
    }

    func decrementProductStockCount(productId: Int) {
        <#code#>
    }

    func getLiveWishListIds() -> [Int] {
        <#code#>
    }

    func getWishList() -> [Product] {
        <#code#>
    }

    func getWishListCount() -> Int {
        <#code#>
    }


}
