//
//  CodedErrorTypeTests.swift
//  Tests
//
//  Created by doof nugget on 5/1/16.
//
//

import XCTest
import LVGUtilities

class CodedErrorTypeTests: XCTestCase {
    
    enum CodedError: CodedErrorType {
        case TestCaseOne(message: String)
        case TestCaseTwo(message: String)
        case Undefined(code: Int32, message: String)
        
        var domain: String {
            return "Coded Error Test Type"
        }
        
        var shortDescription: String {
            switch self {
            case .TestCaseOne:
                return "Test Case One"
            case .TestCaseTwo:
                return "Test Case Two"
            case .Undefined(_):
                return "Undefined"
            }
        }
        
        var code: Int32 {
            switch self {
            case .TestCaseOne: return 1
            case .TestCaseTwo: return 2
            case .Undefined(let (code, _)):
                return code
            }
        }
        
        var message: String {
            switch self {
            case .TestCaseOne(let m): return m
            case .TestCaseTwo(let m): return m
            case .Undefined(let (_, m)): return m
            }
        }
        
        init(status code: Int32, message: String) {
            switch code {
            case 1: self = .TestCaseOne(message: message)
            case 2: self = .TestCaseTwo(message: message)
            default:
                self = .Undefined(code: code, message: message)
            }
        }
    }
    
    func testDomain() {
        let error = CodedError.TestCaseOne(message: "Test message")
        XCTAssertEqual(error.domain, "Coded Error Test Type", "Did not return correct domain.")
    }
    
    func testCode() {
        let error = CodedError.TestCaseOne(message: "Test message")
        XCTAssertEqual(error.code, 1, "Did not return correct code.")
    }
    
    func testRawValue() {
        let error = CodedError.TestCaseOne(message: "Test message")
        XCTAssertEqual(error.rawValue, 1, "Did not return correct rawValue.")
    }
    
    func testRawValueEqualsCode() {
        let error = CodedError.TestCaseTwo(message: "Test message")
        XCTAssertEqual(error.rawValue, error.code, "rawValue does not equal code.")
    }
    
    func testShortDescription() {
        let error = CodedError.TestCaseTwo(message: "Test message")
        XCTAssertEqual(error.shortDescription, "Test Case Two", "Did not return correct shortDescription.")
    }
    
    func testCodeInit() {
        let error = CodedError(status: 2, message: "Test message")
        XCTAssertEqual(error.rawValue, CodedError.TestCaseTwo(message: "Test message").rawValue, "Did not initialize correctly from code 2.")
    }
    
    func testRawValueInit() {
        let error = CodedError(rawValue: 2)
        XCTAssertEqual(error.code, CodedError.TestCaseTwo(message: "Test message").code, "Did not initialize correctly from code 2.")
    }
    
    func testUndefinedInit() {
        let error = CodedError(status: 3, message: "This error is not defined for this domain.")
        XCTAssertEqual(error.code, 3, "Did not initialize undefined error with correct code.")
    }
}
