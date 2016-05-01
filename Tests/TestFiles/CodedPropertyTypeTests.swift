//
//  CodedPropertyTypeTests.swift
//  Tests
//
//  Created by doof nugget on 5/1/16.
//
//

import XCTest
import LVGUtilities

class CodedPropertyTypeTests: XCTestCase {

    enum CodedProperty: CodedPropertyType {
        case TestCaseOne
        case TestCaseTwo
        
        var domain: String {
            return "Coded Property Test Type"
        }
        
        var shortDescription: String {
            switch self {
            case .TestCaseOne:
                return "Test Case One"
            case .TestCaseTwo:
                return "Test Case Two"
            }
        }
        
        var code: UInt32 {
            switch self {
            case .TestCaseOne: return 1
            case .TestCaseTwo: return 2
            }
        }
        
        init?(code: UInt32) {
            switch code {
            case 1: self = .TestCaseOne
            case 2: self = .TestCaseTwo
            default:
                return nil
            }
        }
    }

    func testDomain() {
        let property = CodedProperty.TestCaseOne
        XCTAssertEqual(property.domain, "Coded Property Test Type", "Did not return correct domain.")
    }
    
    func testCode() {
        let property = CodedProperty.TestCaseOne
        XCTAssertEqual(property.code, 1, "Did not return correct code.")
    }
    
    func testRawValue() {
        let property = CodedProperty.TestCaseOne
        XCTAssertEqual(property.rawValue, 1, "Did not return correct rawValue.")
    }
    
    func testRawValueEqualsCode() {
        let property = CodedProperty.TestCaseTwo
        XCTAssertEqual(property.rawValue, property.code, "rawValue does not equal code.")
    }
    
    func testShortDescription() {
        let property = CodedProperty.TestCaseTwo
        XCTAssertEqual(property.shortDescription, "Test Case Two", "Did not return correct shortDescription.")
    }
    
    func testCodeInit() {
        if let property = CodedProperty(code: 2) {
            XCTAssertEqual(property, CodedProperty.TestCaseTwo, "Did not initialize correctly from code 2.")
        } else {
            XCTFail()
        }
    }
    
    func testRawValueInit() {
        if let property = CodedProperty(rawValue: 2) {
            XCTAssertEqual(property, CodedProperty.TestCaseTwo, "Did not initialize correctly from rawValue 2.")
        } else {
            XCTFail()
        }
    }
    
    func testFailedInit() {
        XCTAssertNil(CodedProperty(rawValue: 3), "Init should have returned nil.")
    }
}
