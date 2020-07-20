//
//  HomeController.swift
//
//  Created by Oyeleke Okiki on 7/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class HomeController: BaseViewController {
    private var homePresenter: DataSourcePresenter<Product>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter = DataSourcePresenter(dataControllerDelegate: self,
                                            cartUpdateDelegate: self)
        configureTableView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Home"
        fetchData()
    }

    private func fetchData() {
        homePresenter.refreshWishListIds()
        homePresenter.retrieveData(path: "products")
    }
}

extension HomeController: CartUpdateDelegate {
    func onCartUpdateSuccess(message: String) {
        showTopSuccessNote(message)
        fetchData()
    }

    func onCartUpdateFailed(reason: String) {
        showTopErrorNote(reason)
    }
}


extension HomeController: DataSourceDelegate {
    func dataRetrieved<T>(data: [T]) {
        refreshViewForNewDataState()
    }
    
    func didStartFetchingData() {
        _refreshControl.beginRefreshing()
    }
    
    func dataIsEmpty() {
        refreshViewForNewDataState()
        showTopErrorNote("No items available!")
    }
    
    func dataFetchingFailed(errorMessage: String) {
        _refreshControl.endRefreshing()
        showTopErrorNote(errorMessage)
    }
}

extension HomeController {
    private func configureTableView() {
        tableView.register(UINib.init(nibName: "ProductItemCell", bundle: nil), forCellReuseIdentifier: ProductItemCell.identifier)
        refreshStarted = { [unowned self] in
            self.fetchData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homePresenter.dataCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productItemCell = tableView.dequeueReusableCell(withIdentifier: ProductItemCell.identifier) as! ProductItemCell
        productItemCell.selectionStyle = .none
        let product = homePresenter.itemForRow(row: indexPath.row)
        GenericViewConfigurator.configure(product: product, genericProductView:
            productItemCell.genericProductView)
        productItemCell.addToWishlistButton.setSelected(selected: homePresenter.isItemInWishList(productId: product.id), animated: false)

        productItemCell.addToCartButton.isEnabled = product.stock != 0
        productItemCell.addToCartButton.alpha = product.stock == 0 ? 0.4 : 1

        productItemCell.addedItemToCart = { [weak self] in
            self?.homePresenter.addToCart(id: product.id)
        }

        productItemCell.addedItemToWishList = { [weak self] in
            productItemCell.addToWishlistButton.isSelected ?
                self?.homePresenter.addToWishList(product: product):
                self?.homePresenter.removeFromWishList(product: product)

        }

        return productItemCell
    }
}
