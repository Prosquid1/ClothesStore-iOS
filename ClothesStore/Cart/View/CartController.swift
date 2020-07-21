//
//  CartController.swift
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import SwiftEntryKit

class CartController: BaseViewController {
    
    private var cartPresenter: CartPresenter!
    
    let cartFooterView = CartFooterView()
    let cartFooterDummyView = UIView() //As opposed to instantiating everytime
    
    private func retreiveCart() {
        cartPresenter.retrieveData(path: "cart")
    }
    
    override func viewDidLoad() {
        cartPresenter = CartPresenter(dataControllerDelegate: self,
                                      cartUpdateDelegate: self,
                                      cartProductsDelegate: self)
        super.viewDidLoad()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "My Cart"
        retreiveCart()
    }

}

extension CartController: CartUpdateDelegate {
    func onCartUpdateSuccess(message: String) {
        showTopSuccessNote(message)
        retreiveCart()
    }

    func onCartUpdateFailed(reason: String) {
        showTopErrorNote(reason)
    }
}


//TableView extensions
extension CartController {
    private func configureTableView() {
        tableView.register(UINib.init(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: CartItemCell.identifier)
        refreshStarted = { [unowned self] in
            self.retreiveCart()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartPresenter.dataCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItemCell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier) as! CartItemCell
        cartItemCell.selectionStyle = .none
        let cartItemToProduct = cartPresenter.cartItemsToProductForRow(row: indexPath.row)
        GenericProductViewConfigurator.configure(product: cartItemToProduct.product, productsInCartCount: cartItemToProduct.cartItemIds.count, genericProductView: cartItemCell.genericProductView)
        cartItemCell.removedItemFromCart = { [weak self] in
            self?.cartPresenter.deleteFromCart(id: cartItemToProduct.cartItemIds.first ?? 0)
        }
        return cartItemCell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return cartPresenter.dataCount == 0 ? cartFooterDummyView : cartFooterView
    }
    
}

extension CartController: DataSourceDelegate {
    func dataRetrieved<T>(data: [T]) {
        cartPresenter.setProductsForMapping(cartItems: data as! [CartItem]) //Anti-pattern and additional client-side processing since we can't render a CartItem
    }
    
    func didStartFetchingData() {
        _refreshControl.beginRefreshing()
    }
    
    func dataIsEmpty() {
        cartPresenter.setProductsForMapping(cartItems: []) //Anti-pattern and additional client-side processing since we can't render a CartItem
        refreshViewForNewDataState()
        showTopErrorNote("No items available!")
    }
    
    func dataFetchingFailed(errorMessage: String) {
        _refreshControl.endRefreshing()
        showTopErrorNote(errorMessage)
    }
}

extension CartController: CartProductsDelegate {
    func cartProductsRetrieved(data: [CartItemsToProduct]) {
        refreshViewForNewDataState()
    }
    
    func cartProductsFetchingFailed(errorMessage: String) {
        _refreshControl.endRefreshing()
        refreshViewForNewDataState()
        showTopErrorNote("No items available!")
    }
    func cartValueComputed(formattedValue: String) {
        cartFooterView.productTotalAmountLabel.text = formattedValue
    }
}

