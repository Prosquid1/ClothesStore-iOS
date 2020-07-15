//
//  HomeController.swift
//
//  Created by Oyeleke Okiki on 13/7/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import SwiftEntryKit

class HomeController: BaseViewController {

    private var homePresenter: DataSourcePresenter<Product>!

    private func retreiveProducts() {
        homePresenter.retrieveData(path: "products")
    }

    override func viewDidLoad() {
        self.tabBarController?.title = "Home"
        homePresenter = DataSourcePresenter(dataControllerDelegate: self)
        super.viewDidLoad()
        configureTableView()
        retreiveProducts()
    }
}

extension HomeController: DataControllerDelegate {
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
        resetProductDataWithUI()
        showTopErrorNote(message: "No items available!")
    }

    func resetProductDataWithUI() {
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

extension HomeController {
    private func configureTableView() {
        
        tableView.register(UINib.init(nibName: "ProductItemCell", bundle: nil), forCellReuseIdentifier: ProductItemCell.identifier)
        UIView.animate(views: tableView.visibleCells, animations: AnimationUtils.tableViewAnimations)

        refreshStarted = { [unowned self] in
            self.retreiveProducts()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePresenter.dataCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productItemCell = tableView.dequeueReusableCell(withIdentifier: ProductItemCell.identifier) as! ProductItemCell
        productItemCell.selectionStyle = .none
        GenericViewConfigurator.configure(product: homePresenter.itemForRow(row: indexPath.row), genericProductView:
            productItemCell.genericProductView)
        productItemCell.addToWishlistButton.normalColor = .black
        return productItemCell
    }
}
