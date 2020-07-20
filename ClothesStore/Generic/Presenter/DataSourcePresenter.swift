//
//  DataSourceController.swift
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation


protocol DataControllerDelegate {
    func dataRetrieved<T>(data: [T])
    func didStartFetchingData()
    func dataIsEmpty()
    func dataFetchingFailed(errorMessage: String)
}

protocol CartUpdateDelegate {
    func onCartUpdateSuccess(message: String)
    func onCartUpdateFailed(reason: String)
}

class DataSourcePresenter<T> where T: Codable {
    private var data = [T]()

    let dataControllerDelegate: DataControllerDelegate
    let cartUpdateDelegate: CartUpdateDelegate

    var dataCount: Int {
        get { return data.count }
    }

    required init(dataControllerDelegate: DataControllerDelegate,
                  cartUpdateDelegate: CartUpdateDelegate ) {
        self.dataControllerDelegate = dataControllerDelegate
        self.cartUpdateDelegate = cartUpdateDelegate
    }

    func setupUIWithFetch() {
        retrieveData()
    }

    func itemForRow(row: Int) -> T {
        return data[row]
    }

    func retrieveData(path: String = "\(T.self)", params: [String: Any]? = nil) {
        dataControllerDelegate.didStartFetchingData()

        NetworkHelper<[T]>.makeRequest(path: path, onSuccess: {
            [weak self] data in
            if (data.isEmpty) {
                self?.dataControllerDelegate.dataIsEmpty()
                return
            }

            self?.data = data
            self?.dataControllerDelegate.dataRetrieved(data: data)
        }){ [weak self] errorMessage in
            self?.dataControllerDelegate.dataFetchingFailed(errorMessage: errorMessage)

        }
    }

    func addToCart(id: Int) {
        NetworkHelper<String>.makeRequest(path: "cart",
                                       method: .post,
                                       params: ["productId": id],
                                       onSuccess: {
            [weak self] response in
                                        self?.cartUpdateDelegate.onCartUpdateSuccess(message: response)
        }){ [weak self] errorMessage in
            self?.cartUpdateDelegate.onCartUpdateFailed(reason: errorMessage)

        }
    }

    func deleteFromCart(id: Int) {
        NetworkHelper<CSEmpty>.makeRequest(path: "cart",
                                       method: .delete,
                                       params: ["productId": id],
                                       onSuccess: {
            [weak self] response in
                                        self?.cartUpdateDelegate.onCartUpdateSuccess(message: "Deleted successfully!")
        }){ [weak self] errorMessage in
            self?.cartUpdateDelegate.onCartUpdateFailed(reason: errorMessage)

        }
    }
}
