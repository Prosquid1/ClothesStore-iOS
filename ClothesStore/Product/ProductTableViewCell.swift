//
//  ProductTableViewCell.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    public static let identifier = "ProductTableViewCellID"

    @IBOutlet weak var productImageView: UIImageView!

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productOldPriceLabel: UILabel!
    @IBOutlet weak var productStockCountLabel: UILabel!

    @IBOutlet weak var productAccessoryView: UIView!

    var product: Product! {
        didSet {
            productNameLabel.text = product.name
            productPriceLabel.text = product.price
            productCategoryLabel.text = product.category
            productPriceLabel.text = product.price

            configureProducOldPrice()
            configureAccessoryView()
        }
    }

    private func configureProducOldPrice() {
        if (product.oldPrice == nil) {
            productOldPriceLabel.isHidden = true
            return
        }
        productOldPriceLabel.isHidden = false
        productPriceLabel.attributedText = product.oldPrice?.strikeThrough()
    }

    private func configureAccessoryView() {

    }

}
