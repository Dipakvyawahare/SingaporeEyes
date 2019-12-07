//
//  URLExtensionsTests.swift
//  SingaporeEyesTests
//
//  Created by Dipak V. Vyawahare on 07/12/19.
//  Copyright © 2019 Myorganization. All rights reserved.
//

import XCTest
@testable import SingaporeEyes

class URLExtensionsTests: XCTestCase {

    var url = URL(string: "https://www.mysite.com")!
    let params = ["query1": "hitMyfunction"]
    let queryUrl = URL(string: "https://www.mysite.com?query1=hitMyfunction")!
    
    func testAppendingQueryParameters() {
        XCTAssertEqual(url.appendParameters(params: params), queryUrl)
    }
}
