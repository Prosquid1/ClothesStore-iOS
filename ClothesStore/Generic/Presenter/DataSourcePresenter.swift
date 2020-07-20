//
//  DataSourceController.swift
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

class DataSourcePresenter<T> where T: Codable {
    let wishlistManager: WishListDAO = WishlistDBManager()
    private lazy var wishListIds: [Int] = []

    private var data = [T]()

    let dataControllerDelegate: DataSourceDelegate
    let cartUpdateDelegate: CartUpdateDelegate

    var dataCount: Int {
        get { return data.count }
    }

    required init(dataControllerDelegate: DataSourceDelegate,
                  cartUpdateDelegate: CartUpdateDelegate ) {
        self.dataControllerDelegate = dataControllerDelegate
        self.cartUpdateDelegate = cartUpdateDelegate
    }

    func itemForRow(row: Int) -> T {
        return data[row]
    }

}

//Database
extension DataSourcePresenter {
    func addToWishList(product: Product) {
        wishlistManager.addToWishList(it: product)
    }

    func isItemInWishList(productId: Int) -> Bool {
        wishListIds.contains(productId)
    }

    func refreshWishListIds() {
        wishListIds = wishlistManager.getWishListIds()
    }

    func removeFromWishList(product: Product) {
        wishlistManager.removeFromWishList(productId: product.id)
    }
}

//Network
extension DataSourcePresenter {
    func addToCart(id: Int) {
        NetworkHelper<AddToCartResponse>.makeRequest(path: "cart",
                                                     method: .post,
                                                     params: ["productId": id],
                                                     onSuccess: {
                                                        [weak self] response in
                                                        self?.cartUpdateDelegate.onCartUpdateSuccess(message: response.message)
        }){ [weak self] errorMessage in
            self?.cartUpdateDelegate.onCartUpdateFailed(reason: errorMessage)

        }
    }

    func deleteFromCart(id: Int) {
        NetworkHelper<CSEmptyResponse>.makeRequest(path: "cart",
                                                  method: .delete,
                                                  params: ["id": id],
                                                  onSuccess: {
                                                    [weak self] response in
                                                    self?.cartUpdateDelegate.onCartUpdateSuccess(message: "Deleted successfully!")
        }){ [weak self] errorMessage in
            self?.cartUpdateDelegate.onCartUpdateFailed(reason: errorMessage)

        }
    }

    func retrieveData(path: String = "\(T.self)", params: [String: Any]? = nil) {
        dataControllerDelegate.didStartFetchingData()

        NetworkHelper<[T]>.makeRequest(path: path, onSuccess: {
            [weak self] data in

            guard !data.isEmpty else {
                self?.dataControllerDelegate.dataIsEmpty()
                return
            }

            self?.data = data
            self?.dataControllerDelegate.dataRetrieved(data: data)
        }){ [weak self] errorMessage in
            self?.dataControllerDelegate.dataFetchingFailed(errorMessage: errorMessage)

        }
    }



}

//UI source
extension DataSourcePresenter {
    func setupUIWithFetch() {
        retrieveData()
    }
}
