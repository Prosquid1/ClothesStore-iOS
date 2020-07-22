

//
//  ClothesStoreUITests.swift
//  ClothesStoreUITests
//
//  Created by Oyeleke Okiki on 7/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest

class ClothesStoreUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.activate()
        continueAfterFailure = false
    }

    func testHomeHasItems() {
        XCTAssert(app.tables.cells.count != 0)
    }

    func testWishListHasChanged() {
        let tabBarsQuery = app.tabBars
        let myWishlistButton = tabBarsQuery.buttons["My Wishlist"]
        myWishlistButton.tap()
        let initialWishListItemCount = app.tables.cells.count
        tabBarsQuery.buttons["Home"].tap()
        
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"£99.00").buttons["SaveProductToCartId"]/*[[".cells.containing(.staticText, identifier:\"Almond Toe Court Shoes, Patent Black\")",".buttons[\"Save Product To Cart\"]",".buttons[\"SaveProductToCartId\"]",".cells.containing(.staticText, identifier:\"£99.00\")"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        myWishlistButton.tap()
        XCTAssert(app.tables.cells.count != initialWishListItemCount)
    }

    // As long as AddItemToCartId can be tapped, cell count can never be 0
    func testCartHasChanged() {

        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Home"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Almond Toe Court Shoes, Patent Black")/*@START_MENU_TOKEN@*/.buttons["AddItemToCartId"]/*[[".buttons[\"Add Item to Cart\"]",".buttons[\"AddItemToCartId\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.containing(.staticText, identifier:"Suede Shoes, Blue")/*@START_MENU_TOKEN@*/.buttons["AddItemToCartId"]/*[[".buttons[\"Add Item to Cart\"]",".buttons[\"AddItemToCartId\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        tabBarsQuery.buttons["My Cart"].tap()

        XCTAssert(app.tables.cells.count > 0)

    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
