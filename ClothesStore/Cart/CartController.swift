//
//  CartController.swift
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import SwiftEntryKit

class CartController: BaseViewController {
    
    private var cartPresenter: CartDataSourcePresenter!
    
    let cartFooter = UIView()
    
    private func retreiveCart() {
        cartPresenter.retrieveData(path: "cart")
    }
    
    override func viewDidLoad() {
        
        self.tabBarController?.title = "My Cart"
        cartPresenter = CartDataSourcePresenter(dataControllerDelegate: self,
                                                mappedCartProductsDelegate: self)
        super.viewDidLoad()
        configureTableView()
        retreiveCart()
    }
    
    private func configureFooterView() {
        tableView.tableFooterView = cartFooter
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
        showTopErrorNote(message: "No items available!")
    }
    
    func dataFetchingFailed(errorMessage: String) {
        _refreshControl.endRefreshing()
        showTopErrorNote(message: errorMessage)
    }
}

extension CartController: MappedCartProductsDelegate {
    func cartProductsRetrieved(data: [CartItemsToProduct]) {
        refreshViewForNewDataState()
    }
    
    func cartProductsFetchingFailed(errorMessage: String) {
        _refreshControl.endRefreshing()
        showTopErrorNote(message: "No items available!")
    }
}

