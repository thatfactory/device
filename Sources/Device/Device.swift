import SwiftUI
import Combine

/// Retrieves information about a host device.
@MainActor public class Device {

    // MARK: - Properties

    #if os(iOS) || targetEnvironment(macCatalyst)
    /// Subscribe to this variable to keep track of the orientation changes of the device.
    @Published public var orientation: UIDeviceOrientation = UIDevice.current.orientation
    #endif

    #if os(iOS) || targetEnvironment(macCatalyst) || os(tvOS)
    /// Returns the device's screen size in **points**.
    ///
    /// From Apple's documentation:
    ///
    /// - `iOS` and `macCatalyst` This rectangle is specified in the current coordinate space, which takes into
    /// account any interface rotations in effect for the device. Therefore, the value of this property may change when
    /// the device rotates between portrait and landscape orientations.
    ///
    /// - `tvOS:` This rectangle is based on the device in a portrait-up orientation. This value does not change as
    /// the device rotates.
    public var screenSize: CGRect {
        UIScreen.main.bounds
    }
    #endif

    // MARK: Internal Properties

    /// Enables / disables logging output to both *Xcode's Console* and the macOS *Console app*. `true` by default.
    internal var isLoggingEnabled: Bool = true

    internal var cancellableNotifications = Set<AnyCancellable>()

    // MARK: - Lifecycle

    public init() {
        #if os(iOS) || targetEnvironment(macCatalyst)
        listenToOrientationChangeNotifications()
        #endif
    }
}
