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

        let stockCountHelper = StockCountHelper.getCountType(count: product.stock)

        configureAddToCartButton(stockCountHelper, addToCartButton: genericProductView.addToCartButton)
        configureStockCountLabel(count, stockCountHelper:stockCountHelper , stockCountLabel: genericProductView.productStockCountLabel)

        configureSoldOutText(stockCountHelper == .none , soldOutLabel: genericProductView.productSoldOutText)
        configureProductOldPrice(product.oldPrice,
                                 oldPriceLabel: genericProductView.productOldPriceLabel, spacingConstraint: genericProductView.stockToPriceLabelsXt)
    }

    private static func configureAddToCartButton(_ stockCountHelper: StockCountHelper, addToCartButton: UIButton) {
        addToCartButton.alpha = stockCountHelper == .none ? 0.34 : 1.00
        addToCartButton.isEnabled = stockCountHelper != .none
    }

    private static func configureStockCountLabel(_ count: Int, stockCountHelper: StockCountHelper, _ stockCountLabel: UILabel) {
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

enum StockCountHelper {
    case none
    case low
    case high

    var colorValue: UIColor {
        get {
            switch self {
            case .none: return ColorPalette.red
            case .low: return ColorPalette.green
            case .high: return ColorPalette.moneyBlue
            }
        }
    }

    var isSoldOut: Bool {
        if (self == .none) { return false }
        return true
    }

    static func getCountType(count: Int) -> StockCountHelper {
        if (count == 0) { return .none }
        if (count < 3) { return .low }
        return .high
    }

    static func getFormattedCountText(_ count: Int) -> String {
        if (count == 0) { return "Out of stock" }
        return "\(count) left"
    }
}
