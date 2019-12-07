//
//  TrafficCameraServiceTests.swift
//  SingaporeEyesTests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
@testable import SingaporeEyes

class TrafficCameraServiceTests: XCTestCase {
    var sut: TrafficCameraService!
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func configure() {
        sut = TrafficCameraService()
    }
    
    func testFetchTrafficCameraData() {
        let exp = expectation(description: "FetchTrafficCameraData")
        
        sut.fetchTrafficCamera(date: Date()) { (result) in
            switch result {
            case .success(let data):
                if let firstCam = data?.first {
                    XCTAssertNotNil(URL(string: firstCam.image), "url is in incorrect format")
                }
                
            case .failure:
                XCTFail("The traffic camera coult be fetched")
            }
            
            exp.fulfill()
        }
        waitForExpectations(timeout: 10.0) { (error) in
            print(error ?? "Fetching the Traffic camera data timed out.")
        }
    }
}
