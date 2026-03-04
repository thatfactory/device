import Combine
import SwiftUI

/// Retrieves information about a host device.
///
/// Use ``Device`` to inspect the current platform, operating system version,
/// orientation, and screen size.
@MainActor public class Device {

    // MARK: - Properties

    #if os(iOS) || targetEnvironment(macCatalyst)
    /// The current interface orientation.
    ///
    /// This property is updated whenever
    /// `UIDevice.orientationDidChangeNotification` is posted.
    ///
    /// ```swift
    /// import Combine
    /// import Device
    ///
    /// let device = Device()
    /// let currentOrientation = device.orientation
    ///
    /// var cancellables = Set<AnyCancellable>()
    /// device.$orientation
    ///     .sink { orientation in
    ///         switch orientation {
    ///         case .portrait:
    ///             // Do portrait-specific work.
    ///             break
    ///         case .landscapeRight:
    ///             // Do landscape-specific work.
    ///             break
    ///         default:
    ///             // Handle other orientations.
    ///             break
    ///         }
    ///     }
    ///     .store(in: &cancellables)
    /// ```
    @available(iOS 14.0, macCatalyst 14.0, *)
    @Published public var orientation: UIDeviceOrientation = UIDevice.current.orientation
    #endif

    #if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS)
    /// Returns the device screen bounds in points.
    ///
    /// ```swift
    /// import Device
    ///
    /// let device = Device()
    /// let screenSize = device.screenSize
    /// ```
    @available(iOS 14.0, tvOS 14.0, macCatalyst 14.0, *)
    public var screenSize: CGRect {
        UIScreen.main.bounds
    }
    #endif

    // MARK: Internal Properties

    /// Enables or disables logging output to both Xcode's Console and the
    /// macOS Console app.
    internal var isLoggingEnabled: Bool = true

    internal var cancellableNotifications = Set<AnyCancellable>()

    // MARK: - Lifecycle

    /// Creates a new `Device` value and starts listening for orientation changes
    /// on supported platforms.
    public init() {
        #if os(iOS) || targetEnvironment(macCatalyst)
        listenToOrientationChangeNotifications()
        #endif
    }
}
