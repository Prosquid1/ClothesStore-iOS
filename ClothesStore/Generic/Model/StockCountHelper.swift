//
//  StockCountHelper.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/13/20.
//  Copyright © 2020 Personal. All rights reserved.
//

public enum StockCountHelper {
    case none
    case low
    case high

    var isSoldOut: Bool {
        if (self == .none) { return false }
        return true
    }

    static func getCountType(count: Int) -> StockCountHelper {
        if (count == 0) { return .none }
        if (count < 3) { return .low }
        return .high
    }

    static func getFormattedCountText(_ count: Int) -> String {
        if (count == 0) { return "(Out of stock)" }
        return "(\(count) left)"
    }
}
