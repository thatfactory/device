import XCTest
@testable import Device

@MainActor final class DeviceTests: XCTestCase {

    func testIsLoggingEnabledByDefault() {
        XCTAssertTrue(Device().isLoggingEnabled)
    }

    func testRetrieveDeviceType() {
        let device = Device()
        switch device.type() {
        case .mac(isCatalyst: false), .unknown:
            XCTAssert(true)
        default:
            XCTFail("Expected OS to be \"Mac\" (not Catalyst) or \"Unknown\"")
        }
    }

    func testRetrieveDeviceOS() {
        let device = Device()
        let osVersion = device.os()
        XCTAssertFalse(osVersion.description.isEmpty, "The description is empty.")
        XCTAssertTrue(osVersion.minor >= 0, "The minor version isn't equal or greater than zero.")
        XCTAssertTrue(osVersion.patch >= 0, "The patchVersion version isn't equal or greater than zero.")
    }
}
