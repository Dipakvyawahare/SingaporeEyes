//
//  Camera.swift
//  SingaporeEyes
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import Foundation

// MARK: - Camera
struct Camera: Codable {
    let timestamp: Date
    let image: String
    let location: Location
    let cameraID: String
    let imageMetadata: ImageMetadata
    
    enum CodingKeys: String, CodingKey {
        case timestamp, image, location
        case cameraID = "camera_id"
        case imageMetadata = "image_metadata"
    }
}

// MARK: - ImageMetadata
struct ImageMetadata: Codable {
    let height, width: Int
    let md5: String
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Double
}

struct TrafficImagesRawServerResponse: Decodable {
    struct Items: Decodable {
        let timestamp: Date
        var cameras: [Camera]
    }
    
    var items: [Items]
}
