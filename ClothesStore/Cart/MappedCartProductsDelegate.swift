//
//  MappedCartProductsDelegate.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/15/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

protocol MappedCartProductsDelegate {
    func cartProductsRetrieved(data: [Product])
    func cartProductsFetchingFailed(errorMessage: String)
}
