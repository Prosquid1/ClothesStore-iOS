//
//  RESTHelper.swift
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import Alamofire

class Response<T: Codable>: Codable {
    var data: [T]?
}

let csRequestHeaders: HTTPHeaders = [
    ServerSecrets.HEADER_AUTH_KEY: ServerSecrets.API_KEY,
    "Accept": "application/json"
]
