//
//  TrafficCamerasInteractor.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import UIKit

class TrafficCamerasInteractor {
    var output: TrafficCamerasInteractorPresenterInterface?
    lazy var worker: TrafficCamerasWorker = TrafficCamerasWorker()
}

extension TrafficCamerasInteractor: TrafficCamerasViewControllerInteractorInterface {
    func fetchCameras(request: TrafficCameras.Request) {
        worker.cancelFetchRequest() // cancel older one
        worker.fetchTrafficCamera(date: request.date) {  [weak self] (result) in
            switch result {
            case .success(let data):
                let response = TrafficCameras.Response.init(cameras: data ?? [])
                self?.output?.showCameras(response: response)
            case .failure(let error):
                self?.output?.displayError(error: error)
            }
        }
    }
}
