//
//  ProductViewConfigurator.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ProductViewConfigurator {
    static func configure(product: Product,
                          genericProductView: GenericProductView) {

        if(genericProductView.productNameLabel == nil) { return }
        genericProductView.productNameLabel.text = product.name
        genericProductView.productPriceLabel.text = product.price
        genericProductView.productCategoryLabel.text = product.category
        genericProductView.productPriceLabel.text = product.price?.formatPrice()

        configureProductImageWithName(name: product.name, genericProductView.productImageUIView)
        configureSoldOutText(product.stock == 0, soldOutLabel: genericProductView.productSoldOutText)
        configureProductOldPrice(product.oldPrice,
                                 oldPriceLabel: genericProductView.productOldPriceLabel, spacingConstraint: genericProductView.stockToPriceLabelsXt)
    }

    private static func configureProductImageWithName(name: String, _ view: UIView) {
        view.backgroundColor = ColorUtils.generateColorFromText(string: name)
    }

    private static func configureProductOldPrice(_ oldPrice: String?, oldPriceLabel: UILabel, spacingConstraint: NSLayoutConstraint) {
        oldPriceLabel.isHidden = oldPrice == nil
        spacingConstraint.constant = oldPrice == nil ? 0.0 : 5.0
        oldPriceLabel.attributedText = oldPrice == nil ? nil : oldPrice?.formatPrice().strikeThrough()
    }

    private static func configureSoldOutText(_ productIsSoldOut: Bool, soldOutLabel: UILabel) {
        soldOutLabel.isHidden = !productIsSoldOut
        if (!productIsSoldOut) {
            return
        }
        soldOutLabel.rotate(degrees: 315.0)
    }
}
