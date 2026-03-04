import Foundation

#if canImport(UIKit)
import UIKit
#endif

public extension Device {

    // MARK: - Orientation Changes Notification

    #if os(iOS) || targetEnvironment(macCatalyst)
    /// Starts listening for interface orientation changes.
    ///
    /// `Device` calls this during initialization on supported platforms.
    @available(iOS 14.0, macCatalyst 14.0, *)
    func listenToOrientationChangeNotifications() {
        NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .handleEvents(receiveOutput: { [weak self] notification in
                self?.log(notification: notification)
            })
            .receive(on: DispatchQueue.main)
            .compactMap { notification in
                (notification.object as? UIDevice)?.orientation
            }
            .assign(to: \.orientation, on: self)
            .store(in: &cancellableNotifications)
    }
    #endif
}
