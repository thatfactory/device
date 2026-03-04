# ``Device``

Retrieve host device information in a UI-agnostic way.

@Metadata {
    @Available(iOS, introduced: "14.0")
    @Available(macOS, introduced: "11.0")
    @Available(tvOS, introduced: "14.0")
    @Available(watchOS, introduced: "7.0")
}

## Overview

Use `Device` to inspect runtime platform details, including operating system
version, platform category, screen size, and orientation on supported
platforms.

## Topics

### Core Type

- ``Device``

### Platform Details

- ``Device/type()``
- ``Device/currentType()``
- ``DeviceType``
- ``DeviceType/platformDisplayName``

### Operating System

- ``Device/os()``
- ``OSVersion``

### Display and Orientation

Use `Device.screenSize` on iOS, Mac Catalyst, and tvOS.
Use `Device.orientation` on iOS and Mac Catalyst.

### Logging

- ``Device/enableLogging()``
- ``Device/disableLogging()``
- ``DeviceLoggingCategory``
