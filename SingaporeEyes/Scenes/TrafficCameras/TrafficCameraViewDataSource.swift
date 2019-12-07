//
//  TrafficCameraViewDataSourcec.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import Foundation
import MapKit

class TrafficCameraMapViewDataSource: GenericDataSource<ViewModelCamera>, MapViewDataSource {
    func addAnnotations(_ mapView: MapView) {
        for item in data.value {
            add(camera: item, to: mapView)
        }
    }
    
    private func add(camera: ViewModelCamera,
                     to mapView: MapView) {
        let location = camera.location
        let clLocation = CLLocationCoordinate2D(latitude: location.latitude,
                                                longitude: location.longitude)
        let annotation = CameraPointAnnotation(camera: camera)
        annotation.coordinate = clLocation
        mapView.addAnnotation(annotation)
    }
}
