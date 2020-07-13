//
//  String+Extensions.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func strikeThrough() -> NSAttributedString  {
        return NSAttributedString(string: self, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single])
    }

    func formatPrice() -> String {
        return "£\(self)"
    }
}
