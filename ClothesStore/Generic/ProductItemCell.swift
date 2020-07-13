//
//  CartItemCell.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import FaveButton

class ProductItemCell: UITableViewCell {

    public static let identifier = "ProductItemCellID"
    @IBOutlet weak var genericProductView: GenericProductView!

    @IBOutlet weak var addToWishlistButton: FaveButton!
    @IBOutlet weak var addToCartButton: UIButton!

    func configure(isProductSoldOut: Bool) {
        configureAddToCartButton(isProductSoldOut, addToCartButton: addToCartButton)
    }

    func configureListeners() {
    }

    private func configureAddToCartButton(_ isSoldOut: Bool, addToCartButton: UIButton) {
        addToCartButton.alpha = isSoldOut ? 0.34 : 1.00
        addToCartButton.isEnabled = !isSoldOut
    }

    //TODO: Add listeners

}
