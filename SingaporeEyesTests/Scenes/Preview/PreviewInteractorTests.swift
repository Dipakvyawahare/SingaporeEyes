//
//  PreviewInteractorTests.swift
//  SingaporeEyesTests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
@testable import SingaporeEyes

class PreviewInteractorTests: XCTestCase {
    var sut: PreviewInteractor!
    
    let interactorOutputSpy = PreviewInteractorOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func configure() {
        sut = PreviewInteractor()
        sut.output = interactorOutputSpy
    }
    
    func testPreviewImage() {
        sut.previewImage(request: Preview.Info.init(imageUrl: "", timestamp: Date()))
        XCTAssert(interactorOutputSpy.previewDone, "previewImage() should have been called")
    }
    
    class PreviewInteractorOutputSpy: PreviewInteractorPresenterInterface {
        var previewDone = false
        func previewImage(response: Preview.Info) {
            previewDone = true
        }
    }
}
