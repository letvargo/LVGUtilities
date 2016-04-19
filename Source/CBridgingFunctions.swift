//
//  BridgeFunctions.swift
//  SwiftSystemSoundServices
//
//  Created by doof nugget on 4/12/16.
//  Copyright © 2016 letvargo. All rights reserved.
//

func bridge<T: AnyObject>(obj: T) -> UnsafePointer<Void> {
    return UnsafePointer(Unmanaged.passUnretained(obj).toOpaque())
}

func bridge<T : AnyObject>(ptr: UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(COpaquePointer(ptr)).takeUnretainedValue()
}

func bridgeRetained<T: AnyObject>(obj: T) -> UnsafePointer<Void> {
    return UnsafePointer(Unmanaged.passRetained(obj).toOpaque())
}

func bridgeTransfer<T: AnyObject>(ptr: UnsafePointer<Void>) -> T {
    return Unmanaged<T>.fromOpaque(COpaquePointer(ptr)).takeRetainedValue()
}