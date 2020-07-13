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
        var safeFourCharacterString = string.lowercased()
        safeFourCharacterString.append("....")
        let mutatedString = String(safeFourCharacterString.prefix(3))

        //Randomizing the colors since hex characters from strings are so close, they produce almost the same hue
        let colorArray = mutatedString.map { getModifiedHexInt($0) }

        // Randomizing again to spark up the colors!...
        let red = colorArray[0] + colorArray[1]
        let green = colorArray[1] + colorArray[2]
        let blue = colorArray[2] + colorArray[0]

        return UIColor(rgb: bitShiftColors(red, green, blue))
    }

    static func getModifiedHexInt(_ char: Character) -> Int {
        let charInt = Int(char.asciiValue ?? 0)
        let randomizingSeed = charInt % 2 == 0 ? 1 : 2
        return Int(charInt * randomizingSeed)
    }

    //Ported from Java's Color.rgb function
    static func bitShiftColors(_ red: Int, _ green: Int, _ blue: Int) -> Int {
        return 0xff000000 | (red << 16) | (green << 8) | blue;
    }
}
