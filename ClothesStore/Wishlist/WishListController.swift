//
//  WishListController.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/20/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class WishListController: BaseViewController {

    private var wishListPresenter: WishlistPresenter!

    private func retreiveWishList() {
        wishListPresenter.getWishListItems()
    }

    override func viewDidLoad() {
        self.tabBarController?.title = "Wishlist"
        wishListPresenter = WishlistPresenter(dataControllerDelegate: self,
                                            cartUpdateDelegate: self)
        super.viewDidLoad()
        configureTableView()
        retreiveWishList()
    }
}

extension WishListController: CartUpdateDelegate {
    func onCartUpdateSuccess(message: String) {
        showTopSuccessNote(message)
        retreiveWishList()
    }

    func onCartUpdateFailed(reason: String) {
        showTopErrorNote(reason)
    }
}


extension WishListController: DataSourceDelegate {
    func dataRetrieved<T>(data: [T]) {
        refreshViewForNewDataState()
    }

    func didStartFetchingData() {
        _refreshControl.beginRefreshing()
    }

    func dataIsEmpty() {
        refreshViewForNewDataState()
        showTopErrorNote("No items in wishlist!")
    }

    func dataFetchingFailed(errorMessage: String) {
        _refreshControl.endRefreshing()
        showTopErrorNote(errorMessage)
    }
}

extension WishListController {
    private func configureTableView() {
        tableView.register(UINib.init(nibName: "ProductItemCell", bundle: nil), forCellReuseIdentifier: ProductItemCell.identifier)
        refreshStarted = { [unowned self] in
            self.retreiveWishList()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListPresenter.dataCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productItemCell = tableView.dequeueReusableCell(withIdentifier: ProductItemCell.identifier) as! ProductItemCell
        productItemCell.selectionStyle = .none
        let product = wishListPresenter.itemForRow(row: indexPath.row)
        GenericViewConfigurator.configure(product: product, genericProductView:
            productItemCell.genericProductView)
        productItemCell.addToWishlistButton.isSelected = wishListPresenter.isItemInWishList(productId: product.id)

        productItemCell.addedItemToCart = { [weak self] in
            self?.wishListPresenter.addToCart(id: product.id)
        }

        productItemCell.addedItemToWishList = { [weak self] in
            productItemCell.addToWishlistButton.isSelected ?
                self?.wishListPresenter.removeFromWishList(product: product) :
                self?.wishListPresenter.addToWishList(product: product)
        }

        return productItemCell
    }
}
