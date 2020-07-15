//
//  CartDataSourcePresenter.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class CartDataSourcePresenter: DataSourcePresenter<CartItem> {
    
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
            [weak self] data in
            if (data.isEmpty) {
                self?.mappedCartProductsDelegate?.cartProductsFetchingFailed(errorMessage: "No items found")
                return
            }
            
            //self?.data = data
            //self?.dataControllerDelegate.dataRetrieved(data: data)
        }){ [weak self] errorMessage in
            self?.mappedCartProductsDelegate?.cartProductsFetchingFailed(errorMessage: errorMessage)
            
        }
    }
    
    func itemForRow(row: Int) -> Product? {
        return nil
    }
    
}
