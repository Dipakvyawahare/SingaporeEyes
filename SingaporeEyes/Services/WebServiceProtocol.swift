//
//  WebServiceProtocol.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import Foundation
import Alamofire

protocol WebServiceProtocol {
    @discardableResult func fetchData(using params: [String: String],
                                      completion: @escaping (
        (Result<Data, ErrorResult>) -> Void)) -> DataRequest?
}

final class WebService: WebServiceProtocol {
    private init() {}
    let endPoint = URL(string: "")!
    
    static let shared = WebService()
    
    func fetchData(using params: [String: String],
                   completion: @escaping ((Result<Data, ErrorResult>) -> Void)) -> DataRequest? {
        let request = Alamofire.request(endPoint, method: .get,
                                        parameters: params).response { (response) in
                                            if let error = response.error {
                                                switch error {
                                                case _ where (error as NSError).code == NSURLErrorCancelled:
                                                    break
                                                default:
                                                    var msg =  "An error occured during request :"
                                                    msg += error.localizedDescription
                                                    completion(.failure(ErrorResult.network(string: msg)))
                                                }
                                                return
                                            }
                                            
                                            if let data = response.data {
                                                completion(.success(data))
                                            }
        }
        return request
    }
}
