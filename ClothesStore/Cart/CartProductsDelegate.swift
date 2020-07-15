//
//  CartProductsDelegate.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/15/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol CartProductsDelegate {
    func cartValueComputed(formattedValue: String)
    func cartProductsRetrieved(data: [CartItemsToProduct])
    func cartProductsFetchingFailed(errorMessage: String)
}
