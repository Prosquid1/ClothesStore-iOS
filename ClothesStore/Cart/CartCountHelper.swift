//
//  CartCountHelper.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/15/20.
//  Copyright © 2020 Personal. All rights reserved.
//

struct CartCountHelper {
    static func getTextForItemCount(_ count: Int) -> String {
        return "(\(count) item\(count != 1 ? "s" : ""))"
    }
}
