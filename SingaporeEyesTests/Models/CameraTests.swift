//
//  CameraTests.swift
//  SingaporeEyesTests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
import Alamofire
@testable import SingaporeEyes

class CameraTests: XCTestCase {
    var cameraService: TrafficCameraService?
    var requestService: MockRequestService?
    
    override func setUp() {
        super.setUp()
        cameraService = TrafficCameraService()
        requestService = MockRequestService()
        cameraService?.requestService = requestService
    }
    
    override func tearDown() {
        cameraService = nil
        requestService = nil
        super.tearDown()
    }

    func testParseTrafficCameras() {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "Sample",
                                              bundle: Bundle(for: CameraTests.self))  else {
                                                XCTAssert(false, "Can't get data from sample.json")
                                                return
        }
        requestService?.data = data
        // giving completion after parsing
        // expected valid TrafficCameras with valid data
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TrafficCameraDateFormatter.request.rawValue
        let url = "https://images.data.gov.sg/api/traffic-images/2019/12/78405cb4-f46e-4dfb-bfd5-1bc1b6f51276.jpg"
        cameraService?.fetchTrafficCamera(date: Date(), { (result) in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid vehicle")
            case .success(let cameras):
                if let cameras = cameras {
                    let camera = cameras[0]
                    XCTAssertEqual(cameras.count,
                                   87,
                                   "Parsing error or sample.json content")
                    XCTAssertEqual(camera.cameraID,
                                   "1702",
                                   "Expected 1702")
                    XCTAssertEqual(camera.image,
                                   url,
                                   "Expected valid url")
                    XCTAssertEqual(camera.timestamp,
                                   dateFormatter.date(from: "2019-12-01T11:00:25+08:00"),
                                   "Expected 2019-12-01T11:00:25+08:00")
                    XCTAssertEqual(camera.location.latitude,
                                   1.34355015,
                                   "Expected 1.34355015")
                    XCTAssertEqual(camera.location.longitude,
                                   103.8601984,
                                   "Expected 103.8601984")
                }
            }
        })
    }
    
    func testParseEmptyData() {
        // giving empty data
        requestService?.data = nil
        cameraService?.fetchTrafficCamera(date: Date(), { (result) in
            switch result {
            case .success:
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        })
    }
    
    class MockRequestService: WebServiceProtocol {
        var data: Data?
        func fetchData(using params: [String: String],
                       completion: @escaping ((SingaporeEyes.Result<Data, ErrorResult>) -> Void)) -> DataRequest? {
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(ErrorResult.custom(string: "No data")))
            }
            return nil
        }
    }
}
