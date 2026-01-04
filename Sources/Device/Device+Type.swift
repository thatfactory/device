import SwiftUI

/// The type of the device, e.g: `.iPhone`, `.mac(isCatalyst: false)`, `.tv`, etc.
public enum DeviceType: Equatable {
    case iPhone
    case iPad
    case mac(isCatalyst: Bool = false)
    case tv
    case watch
    case vision
    case unknown
}

public extension Device {

    /// Returns the `DeviceType`, based on the result of the `os()` and `targetEnvironment()` functions.
    ///
    /// Originally, the documentation for the `os()` function and `Preprocessor Directives` (AKA *Conditional
    /// Compilation Directives*), could be found in this book: *"Using Swift with Cocoa and Objective-C"*; but the book
    /// is [no longer updated / published](https://forums.developer.apple.com/thread/113777). (A copy can be seen
    /// [here](http://bit.ly/35RktOj)). It could be here at some point:
    /// [Apple Swift Documentation](https://developer.apple.com/documentation/swift) -- however I couldn't find any
    /// updated reference to it there.
    ///
    /// There's also [a great NSHipster post](https://nshipster.com/swift-system-version-checking/) regarding this
    /// subject.
    func type() -> DeviceType {
        let deviceType: DeviceType
        #if os(tvOS)
            deviceType = .tv
        #elseif os(watchOS)
            deviceType = .watch
        #elseif os(macOS)
            deviceType = .mac(isCatalyst: false)
        #elseif os(iOS)
        #if targetEnvironment(macCatalyst)
            deviceType = .mac(isCatalyst: true)
        #else
            deviceType = UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
        #endif
        #elseif os(visionOS)
            deviceType = .vision
        #else
            deviceType = .unknown
        #endif
        log(information: "Device type: \(deviceType)", category: .type)
        return deviceType
    }
}
