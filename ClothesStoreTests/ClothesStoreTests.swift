//
//  ClothesStoreTests.swift
//  ClothesStoreTests
//
//  Created by Oyeleke Okiki on 7/9/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest

@testable import ClothesStore

class ClothesStoreTests: XCTestCase {
    var product: Product!
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "TestProduct", withExtension: "json")!
        let exampleJSONData = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        product = try! decoder.decode(Product.self, from: exampleJSONData)

    }
    func testDecodedProduct() {
        XCTAssert(product.id == 1 && product.name == "Test Product")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
