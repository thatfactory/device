import Foundation
import AppLogger

/// `Device` logging categories used to group log output.
///
/// Refer to [Apple logging documentation](https://developer.apple.com/documentation/os/logging).
public enum DeviceLoggingCategory: String {
    case notification = "Device_Notification"
    case os = "Device_OS"
    case type = "Device_Type"
}

// MARK: - Interface

public extension Device {

    // MARK: Enable / Disable Logging

    /// Enables logging output via `AppLogger`.
    ///
    /// When logging is enabled, output is available in Xcode's Console and in
    /// the macOS Console app under subsystem `com.thatfactory.Device`.
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

    /// Logs the given text through `AppLogger`.
    ///
    /// - Parameters:
    ///   - information: The text to log.
    ///   - category: The logging category.
    func log(information: String, category: DeviceLoggingCategory) {
        guard isLoggingEnabled else {
            return
        }
        let subsystem = "com.thatfactory.Device"
        let logger = AppLogger(subsystem: subsystem, category: category.rawValue)
        logger.log(information)
    }

    /// Logs the given notification through `AppLogger`.
    ///
    /// - Parameter notification: The notification to log.
    func log(notification: Notification) {
        log(information: "Received notification: \(notification)", category: .notification)
    }
}
