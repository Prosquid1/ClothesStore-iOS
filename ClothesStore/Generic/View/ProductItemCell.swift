//
//  ProductItemCell.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//
import FaveButton

class ProductItemCell: UITableViewCell {

    public static let identifier = "ProductItemCellID"
    @IBOutlet weak var genericProductView: GenericProductView!

    @IBOutlet weak var addToWishlistButton: FaveButton!
    @IBOutlet weak var addToCartButton: UIButton!

    var addedItemToWishList: (() -> ())?
    var addedItemToCart: (() -> ())?

    func configure(isProductSoldOut: Bool) {
        configureAddToCartButton(isProductSoldOut, addToCartButton: addToCartButton)
    }

    private func configureAddToCartButton(_ isSoldOut: Bool, addToCartButton: UIButton) {
        addToCartButton.alpha = isSoldOut ? 0.34 : 1.00
        addToCartButton.isEnabled = !isSoldOut
    }

    //TODO: Add listeners
    @IBAction func addedItemToWishlist(_ sender: Any) {
        addedItemToWishList?()
    }

    @IBAction func addedItemToCart(_ sender: Any) {
        addedItemToCart?()
    }

}
