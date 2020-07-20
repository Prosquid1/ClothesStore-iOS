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
    
    private func retreiveCart() {
        cartPresenter.retrieveData(path: "cart")
    }
    
    override func viewDidLoad() {
        
        self.tabBarController?.title = "My Cart"
        cartPresenter = CartPresenter(dataControllerDelegate: self,
                                                cartProductsDelegate: self)
        super.viewDidLoad()
        cartFooterView.isHidden = true
        configureTableView()
        retreiveCart()
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
        GenericViewConfigurator.configure(product: cartItemToProduct.product, productsInCartCount: cartItemToProduct.cartItemIds.count, genericProductView: cartItemCell.genericProductView)
        return cartItemCell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return cartFooterView
    }
    
}

extension CartController: DataControllerDelegate {
    func dataRetrieved<T>(data: [T]) {
        cartPresenter.fetchProductsForMapping(cartItems: data as! [CartItem]) //Additional client-side processing since we cam't render a CartItem
    }
    
    func didStartFetchingData() {
        _refreshControl.beginRefreshing()
    }
    
    func dataIsEmpty() {
        refreshViewForNewDataState()
        cartFooterView.isHidden = true
        showTopErrorNote(message: "No items available!")
    }
    
    func dataFetchingFailed(errorMessage: String) {
        _refreshControl.endRefreshing()
        showTopErrorNote(message: errorMessage)
    }
}

extension CartController: CartProductsDelegate {
    func cartProductsRetrieved(data: [CartItemsToProduct]) {
        cartFooterView.isHidden = false
        refreshViewForNewDataState()
    }
    
    func cartProductsFetchingFailed(errorMessage: String) {
        _refreshControl.endRefreshing()
        cartFooterView.isHidden = true
        showTopErrorNote(message: "No items available!")
    }
    func cartValueComputed(formattedValue: String) {
        cartFooterView.productTotalAmountLabel.text = formattedValue
    }
}

