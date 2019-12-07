//
//  SingaporeEyesUITests.swift
//  SingaporeEyesUITests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
@testable import SingaporeEyes

class SingaporeEyesUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    @discardableResult
    func waiterResultWithExpextation(_ element: XCUIElement) -> XCTWaiter.Result {
        let myPredicate = NSPredicate(format: "exists == true")
        let myExpectation = expectation(for: myPredicate, evaluatedWith: element,
                                        handler: nil)
        let result = XCTWaiter().wait(for: [myExpectation], timeout: 5)
        return result
    }
    
    func testSwiping() {
        let map = app.maps.element
        waiterResultWithExpextation(map)
        let isMapExist = map.exists
        XCTAssertTrue(isMapExist)
        map.swipeLeft()
        map.swipeDown()
        map.swipeUp()
    }
    
    func testAnnotationTap() {
        let pin = app.otherElements.matching(identifier: "MapAnnotaAccesIdentifier").element(boundBy: 0)
        waiterResultWithExpextation(pin)
        XCTAssertTrue(pin.exists)
        pin.tap()
        
        let button = app.buttons["close 96"]
        let imageView = app.images["ImagePreview"]
        waiterResultWithExpextation(button)
        XCTAssertTrue(button.exists)
        XCTAssertTrue(imageView.exists)
        
        button.tap()
    }
}
