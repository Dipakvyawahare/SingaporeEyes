//
//  TrafficCamerasModels.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import Foundation
import UIKit

typealias ViewModelCamera = TrafficCameras.ViewModelCamera
typealias ViewModelLocation = TrafficCameras.ViewModelLocation

struct TrafficCameras {
    struct Request {
        let date: Date
    }
    
    struct Response {
        let cameras: [Camera]
    }
    
    struct ViewModelCamera {
        let location: ViewModelLocation
        let timestamp: Date
        let image: String
        var displayTitle: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = TrafficCameraDateFormatter.display.rawValue
            return dateFormatter.string(from: timestamp)
        }
    }
    
    struct ViewModelLocation: Codable {
        let latitude, longitude: Double
    }
}
