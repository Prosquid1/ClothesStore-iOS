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
