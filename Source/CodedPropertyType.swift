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
    
    /// Initialize a `CodedPropertyType` from a `UInt32` value.
    init?(code: UInt32)
     
    /// The numeric value of the constant that represents the property.
    var code: UInt32 { get }
    
    /// A `String` that identifies the API that defines the property.
    var domain: String { get }
    
    /// A short description of the property.
    var shortDescription: String { get }
}

extension CodedPropertyType {
    
    /// The `rawValue` for `CodedPropertyType` is an `UInt32`.
    public typealias RawValue = UInt32
    
    /// The default implementation calls `self.init(code: rawValue)`.
    public init?(rawValue: UInt32) {
        self.init(code: rawValue)
    }
    
    /**
     
     The printable, formatted description of the property.
     
     The `description` will include information about the `domain`,
     the `shortDescription` and the `code` properties. If the `code` property
     represents a valid 'FourCharCode', the `codeString` will also be printed.
     
     */

    public var description: String {
        
        var base = "\(self.domain): \(self.shortDescription)\n\tCode: \(self.code)"
        
        if let codeString = self.code.codeString {
            base.append(" ('\(codeString)')")
        }
        
        return base
    }
     
    /// The default implementation returns the same value as `code`.
    public var rawValue: UInt32 {
        return self.code
    }
}
