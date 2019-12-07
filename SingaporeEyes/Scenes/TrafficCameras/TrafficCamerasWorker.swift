//
//  TrafficCamerasWorker.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import UIKit

class TrafficCamerasWorker {
    lazy var service: TrafficCameraServiceProtocol? = TrafficCameraService()
    func fetchTrafficCamera(date: Date, _ completion: @escaping ((Result<[Camera]?, ErrorResult>) -> Void)) {
        service?.fetchTrafficCamera(date: date, completion)
    }
    
    func cancelFetchRequest() {
        service?.cancelFetchRequest()
    }
}
