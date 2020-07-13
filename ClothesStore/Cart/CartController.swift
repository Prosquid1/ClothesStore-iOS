//
//  CartController.swift
//
//  Created by Oyeleke Okiki on 11/7/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import SwiftEntryKit

class CartController: BaseViewController {

    private var cartPresenter: DataSourcePresenter<Product>!

    let cartFooter = UIView()

    private func retreiveCart() {
        cartPresenter.retrieveData()
    }

    override func viewDidLoad() {
        self.tabBarController?.title = "My Cart"
        cartPresenter = DataSourcePresenter(dataControllerDelegate: self)
        super.viewDidLoad()
        configureTableView()
        cartPresenter.retrieveData()
    }

    private func configureFooterView() {
        tableView.tableFooterView = cartFooter
    }
}

extension CartController: DataControllerDelegate {
    func dataRetrieved<T>(data: [T]) {
        stopAnimating()
        tableView.reloadData()
        tableView.separatorColor = ColorPalette.tableSeparator
        _refreshControl.endRefreshing()
    }

    func didStartFetchingData() {
        _refreshControl.beginRefreshing()
    }

    func dataIsEmpty() {
        stopAnimating()
        resetCartDataWithUI()
        showTopErrorNote(message: "No items available!")
    }

    func resetCartDataWithUI() {
        stopAnimating()
        _refreshControl.endRefreshing()
        tableView.reloadData()
    }

    func dataFetchingFailed(errorMessage: String) {
        stopAnimating()
        _refreshControl.endRefreshing()
        showTopErrorNote(message: errorMessage)
    }
}

extension CartController {
    private func configureTableView() {
        
        tableView.register(UINib.init(nibName: "ProductItemCell", bundle: nil), forCellReuseIdentifier: ProductItemCell.identifier)
        UIView.animate(views: tableView.visibleCells, animations: AnimationUtils.tableViewAnimations)

        refreshStarted = { [unowned self] in
            self.cartPresenter.retrieveData()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartPresenter.dataCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productItemCell = tableView.dequeueReusableCell(withIdentifier: ProductItemCell.identifier) as! ProductItemCell
        productItemCell.selectionStyle = .none
        GenericViewConfigurator.configure(product: cartPresenter.itemForRow(row: indexPath.row), genericProductView:
            productItemCell.genericProductView)
        return productItemCell
    }
}
