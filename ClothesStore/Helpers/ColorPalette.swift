//
//  ColorPalette.swift
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 20120 Personal. All rights reserved.
//

import UIKit

struct ColorPalette {

    static let primary: UIColor = UIColor(fromHex: 0x795548)
    static let primaryDark: UIColor = UIColor(fromHex: 0x5D4037)
    static let accent: UIColor = UIColor(fromHex: 0xD7CCC8)
    static let lightColor: UIColor = UIColor(fromHex: 0x4FACFE)

    static let black: UIColor = UIColor(fromHex: 0x000000)
    static let dimGray: UIColor = UIColor(fromHex: 0x696969)

    static let topNoteSuccessGreen: UIColor = UIColor(fromHex: 0x65D26E)

    static let green: UIColor = UIColor(fromHex: 0x009688)
    static let grey: UIColor = UIColor(fromHex: 0x808080)

    static let spinner: UIColor = UIColor(fromHex: 0xff9770)

    static let moneyBlue: UIColor = UIColor(fromHex: 0x2e85f6)
    static let red: UIColor = UIColor(fromHex: 0xF44336)
    static let white: UIColor = UIColor(fromHex: 0xFFFFFF)

    static let tableSeparator: UIColor = UIColor(fromHex: 0x8C9CA6, alpha: 0.33)
}

extension UIColor {

    convenience init(fromHex rgbValue: UInt, alpha: CGFloat? = 1.0) {
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
