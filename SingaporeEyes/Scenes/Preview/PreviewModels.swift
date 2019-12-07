//
//  PreviewModels.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright (c) 2019 Globant Inc. All rights reserved.
//

import Foundation
import UIKit

struct Preview {
    struct Info {
        let imageUrl: String
        let timestamp: Date
        var displayTitle: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = TrafficCameraDateFormatter.display.rawValue
            return dateFormatter.string(from: timestamp)
        }
    }
    struct ViewModel {
        let imageUrl: URL
        let timestamp: String
    }
}
