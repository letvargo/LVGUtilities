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
 
     var rawValue: OSStatus { get }
 
 The `rawValue` of the error. The default implementation returns the same 
 value as `code` and is always an `OSStatus` value.
 
     var code: OSStatus { get }
 
 The `OSStatus` that corresponds to the error in the defining API. The 
 'FourCharCode' for the value (if any) can be accessed through its `codeString`
 property.
 
     var domain: String { get }
 
 The domain should be the API that defines the error. For example, the
 errors defined in System Sound Services will have the domain 'System
 Sound Services Error'.
 
     var shortDescription: String { get }
 
 A short description of the property.
 
     var message: String { get }
 
 A message that can provide information about the context from which the
 error was thrown.
 
 **Initializers:**
 
     init(status: OSStatus, message: String)
 
 Initialize `Self` with an `OSStatus` value and a message with information
 about the context from which the error is being thrown.
 
 */

public protocol CodedErrorType: ErrorType, CustomStringConvertible, RawRepresentable {

    /**
    
     The `rawValue` of the error.
     
     The default implementation returns the same value as `code` and is
     always an `OSStatus` value.
    
     */

    var rawValue: OSStatus { get }
    
    /**
     
     The `OSStatus` that corresponds to the error in the defining API.
     
     The 'FourCharCode' for the value (if any) can be accessed through its
     `codeString` property.
     
     */
    
    var code: OSStatus { get }
    
    /**
     
     The the API that defines the error.
     
     For example, the errors defined in System Sound Services should
     have the domain 'System Sound Services Error'.
     
     */
    
    var domain: String { get }
    
    /**
     
     A short description of the error.
     
     */
    
    var shortDescription: String { get }
    
    /**
     
     A message that can provide information about the context from which the
     error was thrown.
     
     */
    
    var message: String { get }
    
    /**
     
     Checks the `status` and throws a `CodedErrorType` if `status != noErr`.
     
     - parameter status: The `OSStatus` value that should be checked.
     - parameter message: A message that can provide information about the
     context from which the error is being thrown.
     
     - throws: `Self`, a `CodedErrorType`.
     
     */
    
    static func check(status: OSStatus, message: String) throws
    
    /**
     
     Initialize `Self` with an `OSStatus` value and a `message` with 
     information about the context from which the error is being thrown.
     
     - parameter status: The `OSStatus` code of the error as defined by 
     the API.
     - parameter message: A `String` that can be used to provide helpful
     information about the context from which the error is being thrown.
    
     */
    
    init(status: OSStatus, message: String)
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
        base.appendContentsOf("\n\tMessage: \(message)")
        
        base.appendContentsOf("\n\tCode: \(self.code)")
        
        if let codeString = self.code.codeString {
            base.appendContentsOf(" ('\(codeString)')")
        }
        
        return base
    }
    
    /**
     
     The `rawValue` of the error.
     
     The default implementation returns the same value as `code` and is
     always an `OSStatus` value.
     
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
     
     Checks the `status` and throws a `CodedErrorType` if `status != noErr`.
     
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