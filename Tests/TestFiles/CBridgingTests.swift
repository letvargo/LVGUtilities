//
//  PodTestsTests.swift
//  PodTestsTests
//
//  Created by doof nugget on 4/18/16.
//  Copyright © 2016 letvargo. All rights reserved.
//

import XCTest
import LVGUtilities

class CBridgingFunctionTests: XCTestCase {

    class TestClass {
        var value = 0
    }
    
    var obj = TestClass()
    
    func testEqualityAfterBridgeRetained() {
        let objBridged = toPointerRetain(obj)
        let objUnbridged: TestClass = fromPointerConsume(objBridged)
        XCTAssert(obj === objUnbridged)
    }
    
    func testEqualityAfterBridge() {
        let objBridged = toPointer(obj)
        let objUnbridged: TestClass = fromPointer(objBridged)
        XCTAssert(obj === objUnbridged)
    }
}