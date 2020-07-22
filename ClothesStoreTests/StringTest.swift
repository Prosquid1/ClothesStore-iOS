//
//  StringTest.swift
//  ClothesStoreTests
//
//  Created by Oyeleke Okiki on 7/22/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import ClothesStore

class StringTest: XCTestCase {

    func testFormatPrice() {
        XCTAssert("4".formatPrice() == "£4.00")
    }

    func testStruckThroughText() {
        let stringtoStrikeThrough = "Strike This Test"
        var expectedRange = NSRange(location: 0, length: stringtoStrikeThrough.count)
        XCTAssert(stringtoStrikeThrough.strikeThrough().attributes(at: 0, effectiveRange: &expectedRange).keys.contains(NSAttributedString.Key.strikethroughStyle))
    }

}
