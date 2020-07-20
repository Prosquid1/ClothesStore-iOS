//
//  WishlistPresenter.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/19/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class WishlistPresenter: DataSourcePresenter<Product> {
    private lazy var wishList = {
        return wishlistManager.getWishList()
    }()

    override var dataCount: Int {
        get { return wishList.count }
    }

    override func itemForRow(row: Int) -> Product {
        return wishList[row]
    }

    func getWishListItems() {
        wishList = wishlistManager.getWishList()
        if (wishList.isEmpty) {
            dataControllerDelegate.dataIsEmpty()
            return
        }
        dataControllerDelegate.dataRetrieved(data: wishList)
    }
}

