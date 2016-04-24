//
//  CodedErrorType.swift
//  Pods
//
//  Created by doof nugget on 4/23/16.
//
//

// MARK: CodedErrorType - Definition

/**
 
 A protocol that can be used to convert API-defined `OSStatus` error codes
 into a Swift `ErrorType` with a useful `description` that can be used for
 debugging.
 
 **Properties:**
 
 `var rawValue: UInt32 { get }`
 
 By default, this is the same as the `code` property.
 
 `var code: UInt32 { get }`
 
 The numeric value of the constant that represents the property. The
 'FourCharCode' for the value can be accessed through its `codeString` property.
 
 `var domain: String { get }`
 
 The domain should be the API that defines the property. For example, the
 properties defined in System Sound Services will have the domain 'System
 Sound Services Property'.
 
 `var shortDescription: String { get }`
 
 A short description of the property.
 
 `var message: String { get }`
 
 A message that can provide information about the context from which the
 error was thrown.
 
 `var description: String { get }`
 
 The printable, formatted description of the error. The
 `description` will include information about the `domain`,
 the `shortDescription`, a `message`, and the `code` properties. If the
 `code` property represents a valid 'FourCharCode', the `codeString`
 will also be printed.
 
 */

public protocol CodedErrorType: ErrorType, CustomStringConvertible, RawRepresentable {
    
    var domain: String { get }
    var code: OSStatus { get }
    var shortDescription: String { get }
    var message: String? { get }
    
    static func check(status: OSStatus, message: String) throws
    
    init(status: OSStatus, message: String?)
}

extension CodedErrorType {
    
    /**
     
     The printable, formatted description of the error.
     
     The `description` will include information about the `domain`,
     the `shortDescription`, a `message`, and the `code` properties. If the
     `code` property represents a valid 'FourCharCode', the `codeString`
     will also be printed.
     
     */
    
    public var description: String {
        
        var base = "\(self.domain): \(self.shortDescription)."
        if let message = self.message {
            base.appendContentsOf("\n\tMessage: \(message)")
        }
        
        base.appendContentsOf("\n\tCode: \(self.code)")
        
        if let codeString = self.code.codeString {
            base.appendContentsOf(" ('\(codeString)')")
        }
        
        return base
    }
    
    /**
     
     The `rawValue` of the property.
     
     The default implementation returns the same value as `code`.
     
     */
    
    public var rawValue: OSStatus {
        return self.code
    }
    
    /**
     
     Initialize a `CodedErrorType` by its `rawValue`.
     
     The default implementation calls `self.init(status: rawValue, message: "No message.")`.
     
     */
    
    public init(rawValue: OSStatus) {
        self.init(status: rawValue, message: "No message.")
    }
    
    /**
     
     Checks the `status` and throws a `CodedErrorType` with the `message`
     if `status != noErr`.
     
     - parameter status: The `OSStatus` value that should be checked.
     - parameter message: A message that can provide information about the
     context from which the error is being thrown.
     
     - throws: `Self`, a `CodedErrorType`.
     
     */
    
    public static func check(status: OSStatus, message: String) throws {
        
        guard
            status == noErr
            else
        { throw self.init(status: status, message: message) }
    }
}