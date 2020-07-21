//
//  GenericViewConfigurator.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class GenericProductViewConfigurator {
    static func configure(product: Product,
                          productsInCartCount: Int? = nil,
                          withItemsLeftText: Bool = true,
                          genericProductView: GenericProductView) {

        if(genericProductView.productNameLabel == nil) { return }
        genericProductView.productNameLabel.text = product.name
        genericProductView.productPriceLabel.text = product.price
        genericProductView.productCategoryLabel.text = product.category
        genericProductView.productPriceLabel.text = product.price?.formatPrice()

        configureProductImageWithName(name: product.name, genericProductView.productImageUIView)

        let stockCountHelper = StockCountHelper.getCountType(count: product.stock)

        configureSoldOutText(stockCountHelper == .none , soldOutLabel: genericProductView.productSoldOutText)
        configureProductOldPrice(product.oldPrice,
                                 oldPriceLabel: genericProductView.productOldPriceLabel, spacingConstraint: genericProductView.stockToPriceLabelsXt)

        guard withItemsLeftText else {
            return
        }

        if (productsInCartCount != nil) {
            configureItemInCartCountLabel(productsInCartCount ?? 0, stockCountLabel: genericProductView.productStockCountLabel)
        } else {
            configureStockCountLabel(product.stock, stockCountHelper:stockCountHelper , stockCountLabel: genericProductView.productStockCountLabel)
        }
    }

    private static func configureItemInCartCountLabel(_ count: Int, stockCountLabel: UILabel) {
        stockCountLabel.textColor = ColorPalette.primary
        stockCountLabel.text = CartCountHelper.getTextForItemCount(count)
    }

    private static func configureStockCountLabel(_ count: Int, stockCountHelper: StockCountHelper, stockCountLabel: UILabel) {
        stockCountLabel.textColor = stockCountHelper.colorValue
        stockCountLabel.text = StockCountHelper.getFormattedCountText(count)
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
