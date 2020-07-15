//
//  CartDataSourcePresenter.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class CartDataSourcePresenter: DataSourcePresenter<CartItem> {

    private var products = [Product]()
    var mappedCartProductsDelegate: MappedCartProductsDelegate?
    
    init(dataControllerDelegate: DataControllerDelegate,
         mappedCartProductsDelegate: MappedCartProductsDelegate) {
        super.init(dataControllerDelegate: dataControllerDelegate)
        self.mappedCartProductsDelegate = mappedCartProductsDelegate
    }
    
    required init(dataControllerDelegate: DataControllerDelegate) {
        super.init(dataControllerDelegate: dataControllerDelegate)
    }
    
    func fetchProductsForMapping() {
        NetworkHelper<[Product]>.makeRequest(path: "products", onSuccess: {
            [unowned self] products in
            if (products.isEmpty) {
                self.mappedCartProductsDelegate?.cartProductsFetchingFailed(errorMessage: "No items found")
                return
            }

            self.queryCartItemsForProducts(cartItems: self.data, allProducts: products)
        }){ [weak self] errorMessage in
            self?.mappedCartProductsDelegate?.cartProductsFetchingFailed(errorMessage: errorMessage)
            
        }
    }

    func queryCartItemsForProducts(cartItems: [CartItem], allProducts: [Product]) {
        products = allProducts
        mappedCartProductsDelegate?.cartProductsRetrieved(data: allProducts)
    }
    
    func itemForRow(row: Int) -> Product {
        return products[row]
    }
    
}
