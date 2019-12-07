//
//  TrafficCameraService.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import Foundation
import Alamofire

enum TrafficCameraDateFormatter: String {
    case request = "yyyy-MM-dd'T'HH:mm:ssZ"
    case display = "yyyy-MM-dd'T'hh:mm:ss aa"
}

protocol TrafficCameraServiceProtocol {
    func fetchTrafficCamera(date: Date,
                            _ completion: @escaping ((Result<[Camera]?, ErrorResult>) -> Void))
    func cancelFetchRequest()
}

final class TrafficCameraService: TrafficCameraServiceProtocol, DataParser {
    
    var requestService: WebServiceProtocol? = WebService.shared
    weak var task: DataRequest?
    
    func fetchTrafficCamera(date: Date,
                            _ completion: @escaping ((Result<[Camera]?, ErrorResult>) -> Void)) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = TrafficCameraDateFormatter.request.rawValue
        let params = ["date_time": dateFormat.string(from: date)]
        task = requestService?.fetchData(using: params, completion: { [weak self] (result) in
            switch result {
            case .success(let data):
                if let parsed: Result<TrafficImagesRawServerResponse, ErrorResult> = self?.parse(data: data) {
                    switch parsed {
                    case .success(let poi):
                        completion(.success(poi.items.first?.cameras))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func cancelFetchRequest() {
        task?.cancel()
    }
}
