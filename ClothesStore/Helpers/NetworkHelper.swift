//
//  NetworkHelper.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/15/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftyJSON
import Alamofire

struct AddToCartResponse: Codable {
    var message: String
}
struct CSEmptyResponse: Codable {}

class NetworkHelper<T> where T: Codable {
    static func makeRequest(path: String,
                            method: HTTPMethod = .get,
                            params: [String: Any]? = nil,
                            onSuccess: @escaping  (T) -> (),
                            onFailure: @escaping (String) -> ()) {

        AF.request(ServerSecrets.BASE_URL + path.lowercased(),
                   method: method,
                   parameters: params,
                   encoding: URLEncoding(destination: .queryString),
                   headers: csRequestHeaders).validate().responseJSON { response in
                    switch response.result {
                    case .success:
                        if (T.self == CSEmptyResponse.self) { //Empty response, no need to decode
                            onSuccess(CSEmptyResponse() as! T)
                            return
                        }
                        do {
                            let data = try JSONDecoder().decode(T.self, from: response.data!)
                            onSuccess(data)

                        } catch let error {
                            onFailure(error.localizedDescription)
                        }


                    case .failure:
                        var errorString: String = "Error occured!"
                        do {
                            if let data = response.data,
                                let errorStringMessage = try JSON(data: data)["message"].string ,
                                !errorStringMessage.isEmpty{
                                errorString = errorStringMessage
                            }
                        } catch let error {
                            errorString = error.localizedDescription
                        }
                        onFailure(errorString)
                    }

        }
    }
}
