//
//  MapViewDataSource.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import Foundation

protocol MapViewDataSource: class {
    func addAnnotations(_ mapView: MapView)
    func resetFocus(_ mapView: MapView)
    func selectAnnotation(_ mapView: MapView,
                          at index: Int)
}

extension MapViewDataSource {
    func resetFocus(_ mapView: MapView) {}
    func selectAnnotation(_ mapView: MapView, at index: Int) {}
}
