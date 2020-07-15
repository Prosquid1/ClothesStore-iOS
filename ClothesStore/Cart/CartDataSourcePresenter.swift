//
//  CartDataSourcePresenter.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class CartDataSourcePresenter: DataSourcePresenter<CartItem> {

    private var cartItemsToProduct = [CartItemsToProduct]()
    var mappedCartProductsDelegate: MappedCartProductsDelegate?

    override var dataCount: Int {
        get { return cartItemsToProduct.count }
    }
    
    init(dataControllerDelegate: DataControllerDelegate,
         mappedCartProductsDelegate: MappedCartProductsDelegate) {
        super.init(dataControllerDelegate: dataControllerDelegate)
        self.mappedCartProductsDelegate = mappedCartProductsDelegate
    }
    
    required init(dataControllerDelegate: DataControllerDelegate) {
        super.init(dataControllerDelegate: dataControllerDelegate)
    }
    
    func fetchProductsForMapping(cartItems: [CartItem]) {
        NetworkHelper<[Product]>.makeRequest(path: "products", onSuccess: {
            [unowned self] products in
            if (products.isEmpty) {
                self.mappedCartProductsDelegate?.cartProductsFetchingFailed(errorMessage: "No items found")
                return
            }

            self.queryCartItemsForProducts(cartItems: cartItems, allProducts: products)
        }){ [weak self] errorMessage in
            self?.mappedCartProductsDelegate?.cartProductsFetchingFailed(errorMessage: errorMessage)
            
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
        mappedCartProductsDelegate?.cartProductsRetrieved(data: cartItemsToProduct)
    }
    
    func cartItemsToProductForRow(row: Int) -> CartItemsToProduct {
        return cartItemsToProduct[row]
    }
    
}
