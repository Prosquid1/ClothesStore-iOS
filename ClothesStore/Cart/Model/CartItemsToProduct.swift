//
//  CartItemsToProduct.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

class CartItemsToProduct {
    var cartItemIds: [Int]
    var product: Product

    init(product: Product, cartItemIds: [Int]) {
        self.product = product
        self.cartItemIds = cartItemIds
    }
}
