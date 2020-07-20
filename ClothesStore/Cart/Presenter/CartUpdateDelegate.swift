//
//  CartUpdateDelegate.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/20/20.
//  Copyright © 2020 Personal. All rights reserved.
//

protocol CartUpdateDelegate {
    func onCartUpdateSuccess(message: String)
    func onCartUpdateFailed(reason: String)
}
