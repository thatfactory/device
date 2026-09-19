import DeviceTests
import XCTest

var tests: [XCTestCaseEntry] = []
tests += DeviceTests.allTests()
XCTMain(tests)
