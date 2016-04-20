//
//  PodTestsTests.swift
//  PodTestsTests
//
//  Created by doof nugget on 4/18/16.
//  Copyright © 2016 letvargo. All rights reserved.
//

import XCTest
import LVGUtilities

class CBridgingTests: XCTestCase {

    class TestClass {
        var value = 0
    }
    
    var obj = TestClass()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEquality() {
        let objBridged = bridgeRetained(obj)
        let objUnbridged: TestClass = bridgeTransfer(objBridged)
        XCTAssert(obj === objUnbridged)
    }
}