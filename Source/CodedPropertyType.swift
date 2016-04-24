//
//  CodedPropertyType.swift
//  Pods
//
//  Created by doof nugget on 4/23/16.
//
//

// MARK: CodedPropertyType - Definition

/**
 
 A protocol for API-defined properties that are represented by a
 constant `UInt32` value.
 
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
 
 `var description: String { get }`
 
 The printable, formatted description of the property. The `description`
 will include information about the `domain`,
 the `shortDescription` and the `code` properties. If the `code` property
 represents a valid 'FourCharCode', the `codeString` will also be printed.
 
 */

public protocol CodedPropertyType: CustomStringConvertible, RawRepresentable {
    var rawValue: UInt32 { get }
    var code: UInt32 { get }
    var domain: String { get }
    var shortDescription: String { get }
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