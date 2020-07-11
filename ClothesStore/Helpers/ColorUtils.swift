//
//  ColorUtils.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/11/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class ColorUtils {
    /**
     * Helper function to generate a unique and constant color based on the first 3 characters
     * */
    static func generateColorFromText(string: String) -> UIColor {
        var safeFourCharacterString = string
        safeFourCharacterString.append("1234")
        let mutatedString = String(safeFourCharacterString.prefix(4))

        //Randomizing the colors since hex characters from strings are so close, they produce almost the same hue
        let colorArray = mutatedString.map { getModifiedHexFloat($0) }

        // Randomizing again to spark up the colors!...
        let red = colorArray[0] + colorArray[1]
        let green = colorArray[1] + colorArray[2]
        let blue = colorArray[2] + colorArray[0]

        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }

    static func getModifiedHexFloat(_ char: Character) -> CGFloat {
        let charInt = char.hexDigitValue ?? 0
        let randomizingSeed = charInt % 2 == 0 ? 1 : 2
        return CGFloat(charInt * randomizingSeed)
    }
}
