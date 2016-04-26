//
//  FourCharCodeUtilities.swift
//  Pods
//
//  Created by doof nugget on 4/23/16.
//
//

import Foundation

// MARK: CodeStringConvertible - Definition

/**
 
 Converts a 4-byte integer type to a 4-character `String`.
 
 By default, only `UInt32` and `Int32` conform to this protocol.
 Various `typealias`es for these two types will also conform, including
 `OSStatus` and `FourCharCode`.
 
 Many Apple APIs have error codes or constants that can be converted
 to a 4-character string. Valid 4-character code strings are exactly
 4 characers long and every character is between ASCII values 32..<127.
 
 For example, the constant `kAudioServicesBadPropertySizeError` defined in
 Audio Toolbox has a 4-character code string '!siz'. Many `OSStatus` error
 codes have 4-character code strings associated with them, and these
 can be useful for debugging.
 
 */

public protocol CodeStringConvertible {
    
    /**
     
     A `String`, exactly 4 ASCII characters in length, that represents
     the 'FourCharCode' of the value.
     
     Many Apple APIs have error codes or constants that can be converted
     to a 4-character string. Valid 4-character code strings are exactly
     4 characers long and every character is between ASCII values 32..<127.
     
     For example, the constant `kAudioServicesBadPropertySizeError` defined in
     Audio Toolbox has a 4-character code string '!siz'. Many `OSStatus` error
     codes have 4-character code strings associated with them, and these
     can be useful for debugging.
     
     If the value that this is called on is not exactly 4 bytes in size,
     or if any of the bytes (interpreted as a `UInt8`) does not represent an
     ASCII value contained in `32..<127`, the `codeString` property will be `nil`.
     
     */
    
    var codeString: String? { get }
}

extension CodeStringConvertible {
    
    public var codeString: String? {
        
        let size = sizeof(self.dynamicType)
        
        guard size == 4 else { fatalError("Only types whose size is exactly 4 bytes can conform to `CodeStringConvertible`") }
        
        func parseBytes(value: UnsafePointer<Void>) -> [UInt8]? {
            
            let ptr = UnsafePointer<UInt8>(value)
            var bytes = [UInt8]()
            
            for index in (0..<size).reverse() {
                
                let byte = ptr.advancedBy(index).memory
                
                if (32..<127).contains(byte) {
                    
                    bytes.append(byte)
                    
                } else {
                    
                    return nil
                }
            }
            
            return bytes
        }
        
        if  let bytes = parseBytes([self]),
            let output = NSString(
                bytes: bytes
                , length: size
                , encoding: NSUTF8StringEncoding) as? String {
            
            return output
        }
        
        return nil
    }
}

extension OSStatus: CodeStringConvertible { }

extension UInt32: CodeStringConvertible { }

// MARK: String - Extension adding the code property

extension String {

    /**
     
     Converts a 4-character string to a `UInt32` value.
     
     This property is the reverse of the `codeString` property defined
     in `CodeStringConvertible`.
     
     - precondition: `self.unicodeScalars.count == 4` where every scalar
     has a value in the range `32..<127`. If these conditions are not met
     the function will return `nil`.
     
     */
    
    public func propertyCode() -> UInt32? {
        
        func pointsToUInt32(points: UnsafePointer<UInt8>) -> UInt32 {
            return UnsafePointer<UInt32>(points).memory
        }
        
        let codePoints = Array(self.utf8.reverse())
        
        guard
            codePoints.count == 4
            else {
                return nil
        }
        
        guard
            codePoints.reduce(true, combine: { $0 && (32..<127).contains($1) })
            else {
                return nil
        }
        
        return pointsToUInt32(codePoints)
    }
    
    /**
     
     Converts a 4-character string to an `Int32` value.
     
     This property is the reverse of the `codeString` property defined
     in `CodeStringConvertible`.
     
     - precondition: `self.unicodeScalars.count == 4` where every scalar
     has a value in the range `32..<127`. If these conditions are not met
     the function will return `nil`.
     
     */
    
    public func statusCode() -> OSStatus? {
        
        func pointsToInt32(points: UnsafePointer<UInt8>) -> Int32 {
            return UnsafePointer<Int32>(points).memory
        }
        
        let codePoints = Array(self.utf8.reverse())
        
        guard
            codePoints.count == 4
            else {
                return nil
        }
        
        guard
            codePoints.reduce(true, combine: { $0 && (32..<127).contains($1) })
            else {
                return nil
        }
        
        return pointsToInt32(codePoints)
    }
}
