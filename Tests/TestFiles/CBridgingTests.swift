//
//  PodTestsTests.swift
//  PodTestsTests
//
//  Created by doof nugget on 4/18/16.
//  Copyright © 2016 letvargo. All rights reserved.
//

import XCTest
import LVGUtilities

class PodTestsTests: XCTestCase {

    class TestClass {
        var value = 0
    }
    
    var obj = TestClass()
    
    func testEqualityAfterBridgeRetained() {
        let objBridged = bridgeRetained(obj)
        let objUnbridged: TestClass = bridgeTransfer(objBridged)
        XCTAssert(obj === objUnbridged)
    }
    
    func testEqualityAfterBridge() {
        let objBridged = bridge(obj)
        let objUnbridged: TestClass = bridge(objBridged)
        XCTAssert(obj === objUnbridged)
    }
}