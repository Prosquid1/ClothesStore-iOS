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
    func strikeThrough() -> NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }

    func formatPrice() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "GBP"
            formatter.maximumFractionDigits = 2
            if let validCurrency = formatter.string(for: value) {
                return validCurrency
            }
        }
        return "£0.00"
    }
}
