import UIKitSugar
import XCTest

class NSLayoutConstraint_UIKitSugarTests: XCTestCase {
  func testWithPriority() {
    var constraint = NSLayoutConstraint()
    constraint.priority = .defaultLow
    XCTAssertEqual(constraint.priority, .defaultLow)
    constraint = constraint.with(priority: .defaultHigh)
    XCTAssertEqual(constraint.priority, .defaultHigh)
  }
  
  func testNearlyRequiredPriority() {
    XCTAssertEqual(UILayoutPriority.nearlyRequired, UILayoutPriority.required - 1)
  }
}
