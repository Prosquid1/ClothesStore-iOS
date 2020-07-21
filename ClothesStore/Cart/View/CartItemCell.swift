//
//  CartItemCell.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/15/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import FaveButton

class CartItemCell: UITableViewCell {

    public static let identifier = "CartItemCellID"
    @IBOutlet weak var genericProductView: GenericProductView!

    var removedItemFromCart: (() -> ())?

    @IBAction func removedItemFromCart(_ sender: Any) {
        removedItemFromCart?()
    }

}
