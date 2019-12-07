//
//  TrafficCamerasInterfaces.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

protocol TrafficCamerasViewControllerInteractorInterface {
    func fetchCameras(request: TrafficCameras.Request)
}

protocol TrafficCamerasInteractorPresenterInterface {
    func showCameras(response: TrafficCameras.Response)
    func displayError(error: ErrorResult)
}

protocol TrafficCamerasPresenterViewControllerInterface: class {
    func displayError(error: ErrorResult)
}
