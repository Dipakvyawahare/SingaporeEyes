//
//  PreviewPresenterTests.swift
//  SingaporeEyesTests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
@testable import SingaporeEyes

class PreviewPresenterTests: XCTestCase {
    var sut: PreviewPresenter!
    let presenterOutputSpy = PreviewPresenterOutputSpy()
    
    override func setUp() {
        super.setUp()
        configure()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func configure() {
        sut = PreviewPresenter()
        sut.output = presenterOutputSpy
    }
    
    func testPreviewImage() {
        let url = "https://images/2019/12/78405cb4-f46e-4dfb-bfd5-1bc1b6f51276.jpg"
        sut.previewImage(response: Preview.Info.init(imageUrl: url,
                                                     timestamp: Date()))
        XCTAssert(presenterOutputSpy.previewDone, "previewImage() should have been called")
    }
    
    class PreviewPresenterOutputSpy: PreviewPresenterViewControllerInterface {
        var previewDone = false
        func previewImage(viewModel: Preview.ViewModel) {
            previewDone = true
        }
    }
}
