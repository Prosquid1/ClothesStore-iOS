//
//  DataSourceDelegate.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/20/20.
//  Copyright © 2020 Personal. All rights reserved.
//

protocol DataSourceDelegate {
    func dataRetrieved<T>(data: [T])
    func didStartFetchingData()
    func dataIsEmpty()
    func dataFetchingFailed(errorMessage: String)
}
