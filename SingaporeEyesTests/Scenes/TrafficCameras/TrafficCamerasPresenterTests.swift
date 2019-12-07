//
//  TrafficCamerasPresenterTests.swift
//  SingaporeEyesTests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
@testable import SingaporeEyes

class TrafficCamerasPresenterTests: XCTestCase {
    var sut: TrafficCamerasPresenter!
    let presenterOutputSpy = TrafficCamerasPresenterOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func configure() {
        sut = TrafficCamerasPresenter()
        sut.output = presenterOutputSpy
    }
    
    func testTrafficCamerasImage() {
        sut.displayError(error: ErrorResult.network(string: ""))
        XCTAssert(presenterOutputSpy.errorShown, "displayError() should have been called")
    }
    
    class TrafficCamerasPresenterOutputSpy: TrafficCamerasPresenterViewControllerInterface {
        var errorShown = false
        func displayError(error: ErrorResult) {
            errorShown = true
        }
    }
}
