//
//  HomeController.swift
//
//  Created by Oyeleke Okiki on 7/13/20.
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
        refreshViewForNewDataState()
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

extension HomeController {
    private func configureTableView() {
        tableView.register(UINib.init(nibName: "ProductItemCell", bundle: nil), forCellReuseIdentifier: ProductItemCell.identifier)
        refreshStarted = { [unowned self] in
            self.retreiveProducts()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePresenter.dataCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productItemCell = tableView.dequeueReusableCell(withIdentifier: ProductItemCell.identifier) as! ProductItemCell
        productItemCell.selectionStyle = .none
        GenericViewConfigurator.configure(product: homePresenter.itemForRow(row: indexPath.row), genericProductView:
            productItemCell.genericProductView)
        productItemCell.addToWishlistButton.isSelected = false
        return productItemCell
    }
}
