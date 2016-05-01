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
 
 */

public protocol CodedPropertyType: CustomStringConvertible, RawRepresentable {
    
    /// The `rawValue` of the property.
    var rawValue: UInt32 { get }
     
    /// The numeric value of the constant that represents the property.
    var code: UInt32 { get }
    
    /// A `String` that identifies the API that defines the property.
    var domain: String { get }
    
    /// A short description of the property.
    var shortDescription: String { get }
    
    /// Initialize a `CodedPropertyType` from a `UInt32` value.
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
     
    /// The default implementation returns the same value as `code`.
    public var rawValue: UInt32 {
        return self.code
    }
    
    /// The default implementation calls `self.init(code: rawValue)`.
    public init?(rawValue: UInt32) {
        self.init(code: rawValue)
    }
}