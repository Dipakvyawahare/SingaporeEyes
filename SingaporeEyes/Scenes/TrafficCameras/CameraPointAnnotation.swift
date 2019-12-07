//
//  CameraPointAnnotation.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import MapKit

class CameraPointAnnotation: MKPointAnnotation {
    var camera: ViewModelCamera
    init(camera: ViewModelCamera) {
        self.camera = camera
    }
}
