//
//  CartPresenter.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class CartPresenter: DataSourcePresenter<CartItem> {

    private var cartItemsToProduct = [CartItemsToProduct]()
    var cartProductsDelegate: CartProductsDelegate?

    override var dataCount: Int {
        get { return cartItemsToProduct.count }
    }
    
    init(dataControllerDelegate: DataControllerDelegate,
         cartProductsDelegate: CartProductsDelegate) {
        super.init(dataControllerDelegate: dataControllerDelegate)
        self.cartProductsDelegate = cartProductsDelegate
    }
    
    required init(dataControllerDelegate: DataControllerDelegate) {
        super.init(dataControllerDelegate: dataControllerDelegate)
    }
    
    func fetchProductsForMapping(cartItems: [CartItem]) {
        NetworkHelper<[Product]>.makeRequest(path: "products", onSuccess: {
            [unowned self] products in
            if (products.isEmpty) {
                self.cartProductsDelegate?.cartProductsFetchingFailed(errorMessage: "No items found")
                return
            }

            self.queryCartItemsForProducts(cartItems: cartItems, allProducts: products)
        }){ [weak self] errorMessage in
            self?.cartProductsDelegate?.cartProductsFetchingFailed(errorMessage: errorMessage)
            
        }
    }

    func queryCartItemsForProducts(cartItems: [CartItem], allProducts: [Product]) {
        let cartItemsGroupedByProduct = Dictionary(grouping: cartItems, by: { (element: CartItem) in
            return element.productId
        })
        let productIdToProductMap = Dictionary(uniqueKeysWithValues: allProducts.map{($0.id, $0)})

        cartItemsToProduct = cartItemsGroupedByProduct.map{
            CartItemsToProduct(product: productIdToProductMap[$0.key]!, cartItemIds: $0.value.map {$0.id})
        }
        cartProductsDelegate?.cartProductsRetrieved(data: cartItemsToProduct)
        computeCartItemTotalValue(cartItemsToProduct)
    }

    private func computeCartItemTotalValue(_ cartItemsToProduct: [CartItemsToProduct]) {
        let totalValue = cartItemsToProduct.reduce(0, {$0 + (Double($1.product.price!) ?? 0) * Double($1.cartItemIds.count) }
        )
        cartProductsDelegate?.cartValueComputed(formattedValue: String(totalValue).formatPrice() )

    }
    
    func cartItemsToProductForRow(row: Int) -> CartItemsToProduct {
        return cartItemsToProduct[row]
    }
    
}
