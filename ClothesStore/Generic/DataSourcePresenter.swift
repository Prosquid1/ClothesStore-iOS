//
//  DataSourceController.swift
//
//  Created by Oyeleke Okiki on 12/7/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol DataControllerDelegate {
    func dataRetrieved<T>(data: [T])
    func didStartFetchingData()
    func dataIsEmpty()
    func dataFetchingFailed(errorMessage: String)
}

class DataSourcePresenter<T> where T: Codable {

    var isFetching = false

    private var data = [T]()

    let dataControllerDelegate: DataControllerDelegate

    var dataCount: Int {
        get { return data.count }
    }

    required init(dataControllerDelegate: DataControllerDelegate) {
        self.dataControllerDelegate = dataControllerDelegate
    }

    func setupUIWithFetch() {
        retrieveData()
    }

    func itemForRow(row: Int) -> T {
        return data[row]
    }

    func retrieveData(path: String = "\(T.self)", params: [String: Any]? = nil) {

        isFetching = true
        dataControllerDelegate.didStartFetchingData()

        AF.request( ServerSecrets.BASE_URL + path.lowercased(),
            parameters: params,
            encoding: URLEncoding(destination: .queryString),
            headers: csRequestHeaders).validate().responseJSON { [weak self] response in
                debugPrint(response)
                switch response.result {
                case .success:
                    do {
                        let data = try JSONDecoder().decode([T].self, from: response.data!)
                        if (data.isEmpty) {
                            self?.dataControllerDelegate.dataIsEmpty()
                            return
                        }

                        self?.data = data
                        self?.dataControllerDelegate.dataRetrieved(data: data)

                    } catch let error {
                        self?.dataControllerDelegate.dataFetchingFailed(errorMessage: error.localizedDescription)
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
                        self?.dataControllerDelegate.dataFetchingFailed(errorMessage: error.localizedDescription)
                    }
                    self?.dataControllerDelegate.dataFetchingFailed(errorMessage: errorString)
                }

        }
    }

}
