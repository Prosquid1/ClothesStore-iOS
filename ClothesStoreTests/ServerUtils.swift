//
//  ServerUtils.swift
//  ClothesStoreTests
//
//  Created by Oyeleke Okiki on 7/22/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import XCTest
@testable import ClothesStore

class ServerUtils: XCTestCase {

    func testProjectKeysSetup() {
        let url = URL(string: ServerSecrets.BASE_URL)!
        XCTAssert(UIApplication.shared.canOpenURL(url))
    }

}
