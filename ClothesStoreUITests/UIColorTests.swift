//
//  UIColorTests.swift
//  ClothesStoreUITests
//
//  Created by Oyeleke Okiki on 7/22/20.
//  Copyright © 2020 Personal. All rights reserved.
//


import XCTest

class UIColorTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.activate()
        continueAfterFailure = false
    }

    func testGenerateColorFromText() {
        XCTAssert(ColorUtils.generateColorFromText(string: "Test string").cgColor.hashValue ==  7548502227)
    }

    func testModifiedHexInt() {
        XCTAssert(ColorUtils.getModifiedHexInt("A") ==  130)
    }

    func testBitShiftedColors() {
        XCTAssert(UIColor(rgb: ColorUtils.bitShiftColors(0, 0, 0)).cgColor.hashValue ==  4651078657)
    }
}

