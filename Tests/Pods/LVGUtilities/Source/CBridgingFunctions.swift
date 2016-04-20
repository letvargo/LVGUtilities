//
//  BridgeFunctions.swift
//  SwiftSystemSoundServices
//
//  Created by doof nugget on 4/12/16.
//  Copyright © 2016 letvargo. All rights reserved.
//

public func bridge<T: AnyObject>(obj: T) -> UnsafePointer<Void> {
    return UnsafePointer(Unmanaged.passUnretained(obj).toOpaque())
}

public func bridge<T : AnyObject>(ptr: UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(COpaquePointer(ptr)).takeUnretainedValue()
}

public func bridgeRetained<T: AnyObject>(obj: T) -> UnsafePointer<Void> {
    return UnsafePointer(Unmanaged.passRetained(obj).toOpaque())
}

public func bridgeTransfer<T: AnyObject>(ptr: UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(COpaquePointer(ptr)).takeRetainedValue()
}