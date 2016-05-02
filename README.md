# LVGUtilities

[![CI Status](http://img.shields.io/travis/letvargo/LVGUtilities.svg?style=flat)](https://travis-ci.org/letvargo/LVGUtilities)
[![Version](https://img.shields.io/cocoapods/v/LVGUtilities.svg?style=flat)](http://cocoapods.org/pods/LVGUtilities)
[![License](https://img.shields.io/cocoapods/l/LVGUtilities.svg?style=flat)](http://cocoapods.org/pods/LVGUtilities)
[![Platform](https://img.shields.io/cocoapods/p/LVGUtilities.svg?style=flat)](http://cocoapods.org/pods/LVGUtilities)

A set of basic utilities written in Swift, used mainly as a dependency for other projects like `LVGSwiftSimpleSoundServices`.

## Motivation

This framework is a set of utilities that I developed while working on Swift wrappers for the various Audio Toolbox APIs. Working with C language APIs in Swift is awkward, and these utilities make it less so.

The `CBridgingFunctions` file contains a set of functions for converting class objects to and from `const void` C pointers. For example, the function `toPointer(_:)` replaces this awkward bit of code...

    // object is an `AnyObject` of some type
    let pointer = UnsafeMutablePointer(Unmanaged.passUnretained(object).toOpaque())
    
...with this slightly less awkward line:

    let pointer = toPointer(object)
    
The `toPointer(_:)` and `fromPointer` functions cast objects to and from `UnsafeMutablePointer<Void>`, respectively, without retaining or consuming refrences to the object. If you want to retain a reference, use `toPointerRetain(_:)` or `fromPointerConsume(_:)` instead.

The remaining protocols and type extensions are handy for working with Audio Toolbox's many `OSStatus` error codes and API-defined constants. 

For example, `kAudioServicesUnsupportedPropertyError` is an `OSStatus` error code that may be returned by a function from the System Sound Services API. It has a 4-character string translation of `'pty?'`. The `CodedErrorType` protocol can be used as a helpful structure in converting these error codes into standard Swift `ErrorType`s. In `LVGSwiftSystemSoundServices`, the `kAudioServicesUnsupportedPropertyError` gets translated to an `enum` case `.UnsupportedProperty`. When thrown, it has a nice printable description:

    System Sound Services Error: Unsupported property.
        Message: A helpful message that can provide information about the context from where the error was thrown.
        Code: 285229988 ('pty?')

`CodedErrorType` has a static method `check(_:message:)` that checks an `OSStatus` error code and throws an error if it does not equal `0`, with a message to provide information about the context from where the error was thrown.
        
The `CodedPropertyType` is similar, but for API constants that represent API properties. For example, System Sound Services uses the `UInt32` constant `kAudioServicesPropertyIsUISound` to refer to whether or not the sound honors the user's decision to turn off sound effects. In `LVGSwiftSystemSoundServices` this is translated to an `enum` case `.IsUISound`.

Both `CodedErrorType` and `CodedPropertyType` include a property called `code` which returns the constant defined by the API. The also both conform to `RawRepresentable`, where the `rawValue` is, by default the same as the `code` property.

There are also extensions on `OSStatus` (which is just a typealias for `Int32`) and `UInt32`, that convert them to a four-character string through their `codeString` property, where each character is represented by one byte in the four-byte integer type. `String`s exactly four unicode scalars in length can also be converted to either an `Int32` or an `UInt32` value.

## Requirements

- OS X 10.10 or later
- iOS 8.0 or later

## Installation

LVGUtilities is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "LVGUtilities"
```

## Author

letvargo, letvargo@gmail.com

## License

LVGSwiftSystemSoundServices is available under the MIT license. See the LICENSE file for more info.