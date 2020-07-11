//
//  ClothesStoreItemCell.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ClothesStoreItemCell: UITableViewCell {
    //public static let identifier = "ProductTableViewCellID"

    @IBOutlet weak var productSoldOutText: UILabel!

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productOldPriceLabel: UILabel!
    @IBOutlet weak var productStockCountLabel: UILabel!

    @IBOutlet weak var productImageUIView: UIView!

    var product: Product! {
        didSet {
            productNameLabel.text = product.name
            productPriceLabel.text = product.price
            productCategoryLabel.text = product.category
            productPriceLabel.text = product.price

            configureProductImageWithName(name: product.name, productImageUIView)
            configureSoldOutText(product.stock == 0, soldOutLabel: productSoldOutText)
            configureProductOldPrice(product.oldPrice, oldPriceLabel: productOldPriceLabel)
            configureAccessoryView(viewHolder: self.editingAccessoryView)
        }
    }

    public func configureProductImageWithName(name: String, _ view: UIView) {
        productImageUIView.backgroundColor = ColorUtils.generateColorFromText(string: name)
    }

    public func configureAccessoryView(viewHolder: UIView?) {
        self.editingAccessoryView = Bundle.main.loadNibNamed("CartAccessoryView", owner: nil, options: nil)![0] as! CartAccessoryView


    }

    private func configureProductOldPrice(_ oldPrice: String?, oldPriceLabel: UILabel) {
        if (oldPrice == nil) {
            oldPriceLabel.isHidden = true
            return
        }
        oldPriceLabel.isHidden = false
        oldPriceLabel.attributedText = oldPrice?.strikeThrough()
    }

    private func configureSoldOutText(_ productIsSoldOut: Bool, soldOutLabel: UILabel) {
        soldOutLabel.isHidden = productIsSoldOut
        if (!productIsSoldOut) {
            return
        }
        soldOutLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 1.5)
    }

}
