//
//  CodedPropertyType.swift
//  Pods
//
//  Created by doof nugget on 4/23/16.
//
//

// MARK: CodedPropertyType - Definition

/**
 
 A protocol for working with API-defined properties that are represented by a
 constant `UInt32` value.
 
 **Properties:**
 
     var rawValue: UInt32 { get }
     
 The `rawValue` of the property. The default implementation returns the 
 same value as `code` and is always a `UInt32` value.
 
     var code: UInt32 { get }
 
 The numeric value of the constant that represents the property. The
 'FourCharCode' for the value can be accessed through its `codeString` property.
 
     var domain: String { get }
 
 The domain should be the API that defines the property. For example, the
 properties defined in System Sound Services will have the domain 'System
 Sound Services Property'.
 
     var shortDescription: String { get }
 
 A short description of the property.
 
 */

public protocol CodedPropertyType: CustomStringConvertible, RawRepresentable {
    
    /**
     
     The `rawValue` of the property.
     
     The default implementation returns the same value as `code` and is
     always a `UInt32` value.
     
     */
    
    var rawValue: UInt32 { get }
    
    /**
     
     The numeric value of the constant that represents the property. 
     
     The 'FourCharCode' for the value can be accessed through its 
     `codeString` property.
    
     */
    
    var code: UInt32 { get }
    
    /**
    
     A `String` that identifies the API that defines the property.
    
     For example, the properties defined in System Sound Services 
     should have the domain 'System Sound Services Property'.
    
     */
    
    var domain: String { get }
    
    /**
    
     A short description of the property.
    
     */
    
    var shortDescription: String { get }
    
    /**
    
     Initialize a `CodedPropertyType` from a `UInt32` value.
    
     */
    
    init?(code: UInt32)
}

extension CodedPropertyType {
    
    /**
     
     The printable, formatted description of the property.
     
     The `description` will include information about the `domain`,
     the `shortDescription` and the `code` properties. If the `code` property
     represents a valid 'FourCharCode', the `codeString` will also be printed.
     
     */
    
    public var description: String {
        
        var base = "\(self.domain): \(self.shortDescription)\n\tCode: \(self.code)"
        
        if let codeString = self.code.codeString {
            base.appendContentsOf(" ('\(codeString)')")
        }
        
        return base
    }
    
    /**
     
     The `rawValue` of the property.
     
     The default implementation returns the same value as `code`.
     
     */
    
    public var rawValue: UInt32 {
        return self.code
    }
    
    /**
     
     Initialize a `CodedPropertyType` by its `rawValue`.
     
     The default implementation calls `self.init(code: rawValue)`.
     
     */
    
    public init?(rawValue: UInt32) {
        self.init(code: rawValue)
    }
}