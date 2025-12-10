[![swift-version](https://img.shields.io/badge/swift-6.2-ea7a50.svg?logo=swift&logoColor=white)](https://developer.apple.com/swift/)
[![xcode-version](https://img.shields.io/badge/xcode-26.2-50ace8.svg?logo=xcode&logoColor=white)](https://developer.apple.com/xcode/)
[![spm-ready](https://img.shields.io/badge/spm-ready-b68f6a.svg?logo=gitlfs&logoColor=white)](https://developer.apple.com/documentation/xcode/swift-packages)
[![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20iPadOS%20%7C%20macOS%20%7C%20Mac%20Catalyst%20%7C%20tvOS%20%7C%20visionOS-lightgrey.svg?logo=apple&logoColor=white)](https://en.wikipedia.org/wiki/List_of_Apple_operating_systems)
[![license](https://img.shields.io/badge/license-MIT-67ac5b.svg?logo=googledocs&logoColor=white)](https://en.wikipedia.org/wiki/MIT_License)
[![release](https://github.com/thatfactory/device/actions/workflows/release.yml/badge.svg)](https://github.com/thatfactory/device/actions/workflows/release.yml)

# Device 📱
Retrieves information about the host device, such as its **`type`** (*iPhone, iPad, TV, watch*), **`OS version`**, **`orientation`** (*landscape, portrait*), screen size, etc.

## Usage Examples

### Device's Orientation
(Available in **iOS** and **Mac Catalyst**)
```swift
let device = Device()

// At any time:
let currentOrientation = device.orientation

// Observe orientation changes:
var cancellables = Set<AnyCancellable>()
device.$orientation
    .sink { orientation in
        switch orientation {
        case .portrait:
            // Do portrait stuff
        case .landscapeRight:
            // Do landscape stuff
        default:
            // Handle .faceDown, .faceUp, .landscapeLeft, .portraitUpsideDown, .unknown, etc
        }
    }
    .store(in: &cancellables)
```

### Device's Operating System
```swift
let device = Device()
let os = device.os()

// E.g. running in an iOS device:
let os = device.os()
if os.major >= 14 {
    // Do iOS 14 stuff
}

// E.g. running in a macOS device:
if os.major == 11 && os.minor >= 0 {
    // Do macOS 11.0 stuff
}

// Notice: for any platform, ".minor", ".patch" and ".description" are also available.
```

### Device's Screen Size
(Available in **iOS**, **Mac Catalyst** and **tvOS**)
```swift
let device = Device()
let screenSize = device.screenSize
```

### Device's Type
```swift
let device = Device()
switch device.type() {
case .iPhone:
    // Do iPhone stuff
case .iPad:
    // Do iPad stuff
case .tv:
    // Do TV stuff
case .mac(isCatalyst: false):
    // Do Mac stuff
case .mac(isCatalyst: true):
    // Do Catalyst stuff
case .watch:
    // Do Watch stuff
case .unknow:
    // Do Unknown stuff
}
```

## Available Properties
Property | Description
-------- | -----------
`@Published var orientation: UIDeviceOrientation` | Subscribe to this variable to keep track of the orientation changes of the device. Available only in **iOS** and **Mac Catalyst**, as it relies on the [`orientationDidChangeNotification`](https://developer.apple.com/documentation/uikit/uidevice/1620025-orientationdidchangenotification) notification and the [`UIDeviceOrientation`](https://developer.apple.com/documentation/uikit/uideviceorientation) Enumeration.
`public static var screenSize: CGRect` | Returns the device's screen size in **points**.

## Available APIs
API | Description
--- | -----------
`disableLogging()` | Disables logging output.
`enableLogging()` | Enables logging output via [AppLogger](https://github.com/backslash-f/applogger).
`os()` | Returns the operating system version based on `-[NSProcessInfo operatingSystemVersionString]` and `-[NSProcessInfo operatingSystemVersion]`.
`type()` | Returns the type of the device based on the result of the `os()` and `targetEnvironment()` functions.

## Integration
### Xcode
Use Xcode's [built-in support for SPM](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

*or...*

### Package.swift
In your `Package.swift`, add `Device` as a dependency:
```swift
dependencies: [
    .package(
        url: "https://github.com/thatfactory/device",
        from: "0.1.0"
    )
]
```

Associate the dependency with your target:
```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(
                name: "Device",
                package: "device"
            )
        ]
    )
]
```

Run: `swift build`
