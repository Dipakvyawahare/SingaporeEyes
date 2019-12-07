//
//  TrafficCamerasPresenter.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

class TrafficCamerasPresenter: TrafficCamerasInteractorPresenterInterface {
    weak var output: TrafficCamerasPresenterViewControllerInterface?
    
    weak var mapViewDataSource: GenericDataSource<ViewModelCamera>?
    
    func displayError(error: ErrorResult) {
        output?.displayError(error: error)
    }
    
    func showCameras(response: TrafficCameras.Response) {
        var camsList = [ViewModelCamera]()
        for item in response.cameras {
            let loc = ViewModelLocation.init(latitude: item.location.latitude, longitude: item.location.longitude)
            let vmCam = ViewModelCamera.init(location: loc,
                                             timestamp: item.timestamp,
                                             image: item.image)
            camsList.append(vmCam)
        }
        mapViewDataSource?.data.value = camsList
    }
}
