//
//  TrafficCamerasInteractorTests.swift
//  SingaporeEyesTests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
@testable import SingaporeEyes

class TrafficCamerasInteractorTests: XCTestCase {
    var sut: TrafficCamerasInteractor!
    
    let interactorOutputSpy = TrafficCamerasInteractorOutputSpy()
    let workerSpy = TrafficCamerasWorkerSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func configure() {
        sut = TrafficCamerasInteractor()
        sut.output = interactorOutputSpy
        sut.worker = workerSpy
    }
    
    func testTrafficCameras() {
        workerSpy.performFailedTest = false
        workerSpy.cancelledCalled = false
        sut.fetchCameras(request: TrafficCameras.Request(date: Date()))
        XCTAssert(interactorOutputSpy.fetched, "showCameras() should have been called")
        XCTAssert(workerSpy.fetchTrafficCamerasCalled, "fetchTrafficCamera() should have been called")
        XCTAssert(workerSpy.cancelledCalled, "cancelFetchRequest() should have been called")
    }
    
    func testDisplayError() {
        workerSpy.performFailedTest = true
        workerSpy.cancelledCalled = false
        sut.fetchCameras(request: TrafficCameras.Request(date: Date()))
        XCTAssert(interactorOutputSpy.errorShown, "displayError() should have been called")
        XCTAssert(workerSpy.fetchTrafficCamerasCalled, "fetchTrafficCamera() should have been called")
        XCTAssert(workerSpy.cancelledCalled, "cancelFetchRequest() should have been called")
    }
    
    class TrafficCamerasInteractorOutputSpy: TrafficCamerasInteractorPresenterInterface {
        var fetched = false
        var errorShown = false
        func showCameras(response: TrafficCameras.Response) {
            fetched = true
        }
        
        func displayError(error: ErrorResult) {
            errorShown = true
        }
    }
    
    class TrafficCamerasWorkerSpy: TrafficCamerasWorker {
        var fetchTrafficCamerasCalled = false
        var cancelledCalled = false
        var performFailedTest = false
        override func fetchTrafficCamera(date: Date,
                                         _ completion: @escaping ((Result<[Camera]?, ErrorResult>) -> Void)) {
            fetchTrafficCamerasCalled = true
            if performFailedTest == false {
                completion(.success([]))
            } else {
                completion(.failure(.network(string: "")))
            }
        }
        
        override func cancelFetchRequest() {
            cancelledCalled = true
        }
    }
}
