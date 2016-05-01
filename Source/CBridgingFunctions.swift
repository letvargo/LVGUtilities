//
//  BridgeFunctions.swift
//  SwiftSystemSoundServices
//
//  Created by doof nugget on 4/12/16.
//  Copyright © 2016 letvargo. All rights reserved.
//

/**

 Return an `UnsafeMutablePointer<Void>` to any class object.
 
 This function does not retain a reference to the object. If you need to retain
 a reference to the object to ensure that it is not destroyed, use
 `bridgeRetained(_:)` instead.
 
 - parameter object: The the object that you need a point to. It must be a
 class object that conforms to `AnyObject`.
 
 - returns: An `UnsafeMutablePointer<Void>` to `object`.
 
 */

public func bridge<T: AnyObject>(object: T) -> UnsafeMutablePointer<Void> {
    return UnsafeMutablePointer(Unmanaged.passUnretained(object).toOpaque())
}

/**

 Cast an `UnsafePointer<Void>` to an object of type `T`.
 
 This function does not consume a reference to the object. If you need to 
 consume a reference to the object to prevent a retain cyle, use
 `bridgeTransfer(_:)` instead.
 
 Note that when calling this function the compiler may not be able to infer
 the type that you are casting to. Use a type annotation to specify the type
 that you expect.
 
 - parameter pointer: The `UnsafePointer<Void>` that you wish to cast.
 
 - returns: An object of type `T`.
 
 */

public func bridge<T : AnyObject>(pointer: UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(COpaquePointer(pointer)).takeUnretainedValue()
}

/**
 
 Return an `UnsafeMutablePointer<Void>` to any class object and increases the object's
 reference count by one.
 
 This function retains a reference to the object. If you do not want to retain
 a reference to the object, use `bridge(_:)` instead.
 
 - parameter object: The the object that you need a point to. It must be a
 class object that conforms to `AnyObject`.
 
 - returns: An `UnsafeMutablePointer<Void>` to `object`.
 
 */

public func bridgeRetained<T: AnyObject>(obj: T) -> UnsafeMutablePointer<Void> {
    return UnsafeMutablePointer(Unmanaged.passRetained(obj).toOpaque())
}

/**
 
 Cast an `UnsafePointer<Void>` to an object of type `T` and consume
 a reference to the object.
 
 This function consumes a reference to the object. If you do not want to
 consume a reference to the object use `bridge(_:)` instead.
 
 Note that when calling this function the compiler may not be able to infer
 the type that you are casting to. Use a type annotation to specify the type
 that you expect.
 
 - parameter pointer: The `UnsafePointer<Void>` that you wish to cast.
 
 - returns: An object of type `T`.
 
 */

public func bridgeTransfer<T: AnyObject>(ptr: UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(COpaquePointer(ptr)).takeRetainedValue()
}