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

    private var selectedCalendarQueryDate: Date?

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        setNeedsStatusBarAppearanceUpdate()
        self.tabBarController?.tabBar.isHidden = false
    }

    private func retreiveCart() {
        cartPresenter.retrieveData()
    }

    override func viewDidLoad() {
        title = "Cart"
        navigationController?.setNavigationBarHidden(true, animated: false)

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
        tableView.separatorColor = ColorPalette.primary
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
        
        tableView.register(UINib.init(nibName: "CartItemCell", bundle: nil), forCellReuseIdentifier: CartItemCell.identifier)
        UIView.animate(views: tableView.visibleCells, animations: AnimationUtils.tableViewAnimations)

        refreshStarted = { [unowned self] in
            self.cartPresenter.retrieveData()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartPresenter.dataCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItemCell = tableView.dequeueReusableCell(withIdentifier: CartItemCell.identifier) as! CartItemCell
        cartItemCell.selectionStyle = .none
        ProductViewConfigurator.configure(product: cartPresenter.itemForRow(row: indexPath.row), genericProductView:
            cartItemCell.genericProductView)
        return cartItemCell
    }
}
