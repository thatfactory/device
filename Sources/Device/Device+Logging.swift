import SwiftUI
import AppLogger

/// `Device` logging categories to further distinguish the running parts of the package.
///
/// Refer to: https://developer.apple.com/documentation/os/logging
public enum DeviceLoggingCategory: String {
    case type           = "Device_Type"
    case notification   = "Device_Notification"
    case os             = "Device_OS"
}

// MARK: - Interface

public extension Device {

    // MARK: Enable / Disable Logging

    /// Enables logging output via `AppLogger`.
    ///
    /// When logging is enabled, the output will be available in *Xcode's Console* or
    /// in the *macOS Console app*.
    ///
    /// In the **macOS Console app**, you can filter Device's output by
    /// `SUBSYSTEM`: `com.thatfactory.Device`.
    func enableLogging() {
        isLoggingEnabled = true
    }

    /// Disables logging output.
    func disableLogging() {
        isLoggingEnabled = false
    }
}

// MARK: - Internal

internal extension Device {

    /// Logs the given `String` information via `AppLogger`.
    ///
    /// - Parameters:
    ///   - information: The `String` to be logged.
    ///   - category: A member of the `DeviceLoggingCategory` enum.
    func log(information: String, category: DeviceLoggingCategory) {
        guard isLoggingEnabled else {
            return
        }
        let subsystem = "com.thatfactory.Device"
        let logger = AppLogger(subsystem: subsystem, category: category.rawValue)
        logger.log(information)
    }

    /// Logs the given `Notification` via `AppLogger`.
    func log(notification: Notification) {
        log(information: "Received notification: \(notification)", category: .notification)
    }
}
