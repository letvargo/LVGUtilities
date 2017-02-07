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
        case testCaseOne(message: String)
        case testCaseTwo(message: String)
        case undefined(code: Int32, message: String)
        
        var domain: String {
            return "Coded Error Test Type"
        }
        
        var shortDescription: String {
            switch self {
            case .testCaseOne:
                return "Test Case One"
            case .testCaseTwo:
                return "Test Case Two"
            case .undefined(_):
                return "Undefined"
            }
        }
        
        var code: Int32 {
            switch self {
            case .testCaseOne: return 1
            case .testCaseTwo: return 2
            case .undefined(let (code, _)):
                return code
            }
        }
        
        var message: String {
            switch self {
            case .testCaseOne(let m): return m
            case .testCaseTwo(let m): return m
            case .undefined(let (_, m)): return m
            }
        }
        
        init(status code: Int32, message: String) {
            switch code {
            case 1: self = .testCaseOne(message: message)
            case 2: self = .testCaseTwo(message: message)
            default:
                self = .undefined(code: code, message: message)
            }
        }
    }
    
    func testDomain() {
        let error = CodedError.testCaseOne(message: "Test message")
        XCTAssertEqual(error.domain, "Coded Error Test Type", "Did not return correct domain.")
    }
    
    func testCode() {
        let error = CodedError.testCaseOne(message: "Test message")
        XCTAssertEqual(error.code, 1, "Did not return correct code.")
    }
    
    func testRawValue() {
        let error = CodedError.testCaseOne(message: "Test message")
        XCTAssertEqual(error.rawValue, 1, "Did not return correct rawValue.")
    }
    
    func testRawValueEqualsCode() {
        let error = CodedError.testCaseTwo(message: "Test message")
        XCTAssertEqual(error.rawValue, error.code, "rawValue does not equal code.")
    }
    
    func testShortDescription() {
        let error = CodedError.testCaseTwo(message: "Test message")
        XCTAssertEqual(error.shortDescription, "Test Case Two", "Did not return correct shortDescription.")
    }
    
    func testCodeInit() {
        let error = CodedError(status: 2, message: "Test message")
        XCTAssertEqual(error.rawValue, CodedError.testCaseTwo(message: "Test message").rawValue, "Did not initialize correctly from code 2.")
    }
    
    func testRawValueInit() {
        let error = CodedError(rawValue: 2)
        XCTAssertEqual(error.code, CodedError.testCaseTwo(message: "Test message").code, "Did not initialize correctly from code 2.")
    }
    
    func testUndefinedInit() {
        let error = CodedError(status: 3, message: "This error is not defined for this domain.")
        XCTAssertEqual(error.code, 3, "Did not initialize undefined error with correct code.")
    }
}
