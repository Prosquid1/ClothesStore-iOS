//
//  GenericProductView.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class GenericProductView: UIView {
    @IBOutlet weak var productSoldOutText: UILabel!

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productOldPriceLabel: UILabel!
    @IBOutlet weak var productStockCountLabel: UILabel!

    @IBOutlet weak var productImageUIView: UIView!

    private var contentView: UIView!

    // Initialization
    private func loadViewFromNib() -> UIView {
        let selfClass = Swift.type(of: self)
        let bundle = Bundle(for: selfClass)
        let nib = UINib(nibName: String(describing: selfClass), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView

        return view
    }

    // override point
    internal func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleBottomMargin, .flexibleTopMargin]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

}

class GPVConfig {
    static func configure(product: Product,
         genericProductView: GenericProductView) {

        if(genericProductView.productNameLabel == nil) { return }
        genericProductView.productNameLabel.text = product.name
        genericProductView.productPriceLabel.text = product.price
        genericProductView.productCategoryLabel.text = product.category
        genericProductView.productPriceLabel.text = product.price

        configureProductImageWithName(name: product.name, genericProductView.productImageUIView)
        configureSoldOutText(product.stock == 0, soldOutLabel: genericProductView.productSoldOutText)
        configureProductOldPrice(product.oldPrice, oldPriceLabel: genericProductView.productOldPriceLabel)
    }

    private static func configureProductImageWithName(name: String, _ view: UIView) {
        view.backgroundColor = ColorUtils.generateColorFromText(string: name)
    }

    private static func configureProductOldPrice(_ oldPrice: String?, oldPriceLabel: UILabel) {
        if (oldPrice == nil) {
            oldPriceLabel.isHidden = true
            return
        }
        oldPriceLabel.isHidden = false
        oldPriceLabel.attributedText = oldPrice?.strikeThrough()
    }

    private static func configureSoldOutText(_ productIsSoldOut: Bool, soldOutLabel: UILabel) {
        soldOutLabel.isHidden = productIsSoldOut
        if (!productIsSoldOut) {
            return
        }
        soldOutLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 1.5)
    }
}
