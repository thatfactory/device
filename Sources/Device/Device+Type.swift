import Foundation

#if canImport(UIKit)
import UIKit
#endif

/// A host device category.
public enum DeviceType: Equatable {
    case iPad
    case iPhone
    case mac(isCatalyst: Bool = false)
    case tv
    case unknown
    case vision
    case watch
}

public extension DeviceType {

    /// A stable user-facing platform label.
    ///
    /// ```swift
    /// import Device
    ///
    /// let currentType = Device.currentType()
    /// let platformLabel = currentType.platformDisplayName
    /// // Example values: "iOS", "tvOS", "macOS".
    /// ```
    var platformDisplayName: String {
        switch self {
        case .iPhone, .iPad:
            return "iOS"
        case .mac(isCatalyst: false):
            return "macOS"
        case .mac(isCatalyst: true):
            return "Mac Catalyst"
        case .tv:
            return "tvOS"
        case .watch:
            return "watchOS"
        case .vision:
            return "visionOS"
        case .unknown:
            return "Unknown"
        }
    }
}

public extension Device {

    /// Returns the current host device type without creating a `Device` instance manually.
    ///
    /// ```swift
    /// import Device
    ///
    /// let currentType = Device.currentType()
    /// ```
    ///
    /// - Returns: The current host `DeviceType`.
    static func currentType() -> DeviceType {
        Device().type()
    }

    /// Returns the current host device type.
    ///
    /// ```swift
    /// import Device
    ///
    /// let device = Device()
    ///
    /// switch device.type() {
    /// case .iPhone:
    ///     break
    /// case .iPad:
    ///     break
    /// case .tv:
    ///     break
    /// case .mac(isCatalyst: false):
    ///     break
    /// case .mac(isCatalyst: true):
    ///     break
    /// case .watch:
    ///     break
    /// case .vision:
    ///     break
    /// case .unknown:
    ///     break
    /// }
    /// ```
    ///
    /// - Returns: A `DeviceType` value for the current runtime platform.
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
