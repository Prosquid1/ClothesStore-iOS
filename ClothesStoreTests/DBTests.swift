//
//  DBTests.swift
//  ClothesStoreTests
//
//  Created by Oyeleke Okiki on 7/22/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import ClothesStore

class DBTests: XCTestCase {

    var product: Product!
    var wishlistDBManager: WishlistDBManager!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "TestProduct", withExtension: "json")!
        let exampleJSONData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        product = try! decoder.decode(Product.self, from: exampleJSONData)
        wishlistDBManager = WishlistDBManager()
        wishlistDBManager.deleteAll()


    }
    func testDecodedProduct() {
        XCTAssert(product.id == 1 && product.name == "Test Product")
    }

    func testAdditionToDatabase() {
        wishlistDBManager.addToWishList(it: product)
        let retrievedProduct = wishlistDBManager.getWishListItemWith(productId: product.id)
        XCTAssert(product.id == retrievedProduct!.id)
    }

    // This can also serve as a test for wishlist count
    func testDatabaseIsAtomic() {
        wishlistDBManager.addToWishList(it: product)
        wishlistDBManager.addToWishList(it: product)
        wishlistDBManager.addToWishList(it: product)

        let wishlistCount = wishlistDBManager.getWishListCount()
        XCTAssert(wishlistCount == 1)
    }

    func testProductDeletion() {
        wishlistDBManager.addToWishList(it: product)
        wishlistDBManager.deleteAll()

        let wishlist = wishlistDBManager.getWishList()
        XCTAssert(wishlist.isEmpty)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
