import Foundation

/// Operating system version details for the current host.
public struct OSVersion {

    /// A human-readable operating system description.
    ///
    /// For example, `"Version 10.15.3 (Build 19D76)"`.
    public let description: String

    /// The major version number.
    ///
    /// For `10.15.3`, this value is `10`.
    public let major: Int

    /// The minor version number.
    ///
    /// For `10.15.3`, this value is `15`.
    public let minor: Int

    /// The patch version number.
    ///
    /// For `10.15.3`, this value is `3`.
    public let patch: Int
}

public extension Device {

    /// Returns the operating system version.
    ///
    /// This value is derived from `ProcessInfo`.
    ///
    /// ```swift
    /// import Device
    ///
    /// let device = Device()
    /// let operatingSystem = device.os()
    ///
    /// if operatingSystem.major >= 14 {
    ///     // Handle iOS 14+, tvOS 14+, or matching major versions.
    /// }
    ///
    /// if operatingSystem.major == 11 && operatingSystem.minor >= 0 {
    ///     // Handle macOS 11.0+.
    /// }
    /// ```
    ///
    /// - Returns: The current operating system version information.
    func os() -> OSVersion {
        let processInfo = ProcessInfo()
        let operatingSystemVersion = OSVersion(
            description: processInfo.operatingSystemVersionString,
            major: processInfo.operatingSystemVersion.majorVersion,
            minor: processInfo.operatingSystemVersion.minorVersion,
            patch: processInfo.operatingSystemVersion.patchVersion
        )
        log(information: "Device version: \(operatingSystemVersion)", category: .os)
        return operatingSystemVersion
    }
}
