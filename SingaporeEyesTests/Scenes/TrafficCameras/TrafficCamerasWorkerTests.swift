//
//  TrafficCamerasWorkerTests.swift
//  SingaporeEyesTests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
@testable import SingaporeEyes

class TrafficCamerasWorkerTests: XCTestCase {
    var sut: TrafficCamerasWorker!
    let workerOutputSpy = TrafficCameraServiceOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func configure() {
        sut = TrafficCamerasWorker()
        sut.service = workerOutputSpy
    }

    func testFetchTrafficCemeraSuccess() {
        workerOutputSpy.performFailedTest = false
        sut.fetchTrafficCamera(date: Date()) { (result) in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid fetchTrafficCamera() data")
            default:
                break
            }
        }
    }
    
    func testFetchTrafficCemeraFailure() {
        workerOutputSpy.performFailedTest = true
        sut.fetchTrafficCamera(date: Date()) { (result) in
            switch result {
            case .success:
                XCTAssert(false, "Expected failure fetchTrafficCamera()")
            default:
                break
            }
        }
    }
    
    func testCancellation() {
        sut.cancelFetchRequest()
        XCTAssert(workerOutputSpy.cancelledCalled, "cancelFetchRequest() should have been called")
    }
    
    class TrafficCameraServiceOutputSpy: TrafficCameraServiceProtocol {
        var performFailedTest = false
        var cancelledCalled = false
        func fetchTrafficCamera(date: Date, _ completion: @escaping ((Result<[Camera]?, ErrorResult>) -> Void)) {
            if performFailedTest == false {
                completion(.success([]))
            } else {
                completion(.failure(.network(string: "")))
            }
        }
        
        func cancelFetchRequest() {
            cancelledCalled = true
        }
    }
}
