//
//  DB+Extensions.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/19/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import RealmSwift

extension Results {
    func toArray<T: Object>() -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
