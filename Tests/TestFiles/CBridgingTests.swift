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
        let objBridged = toPointerRetain(object: obj)
        let objUnbridged: TestClass = fromPointerConsume(pointer: objBridged)
        XCTAssert(obj === objUnbridged)
    }
    
    func testEqualityAfterBridge() {
        let objBridged = toPointer(object: obj)
        let objUnbridged: TestClass = fromPointer(pointer: objBridged)
        XCTAssert(obj === objUnbridged)
    }
}
