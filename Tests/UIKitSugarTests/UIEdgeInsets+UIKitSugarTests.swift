import XCTest

class UIEdgeInsets_UIKitSugarTests: XCTestCase {
  func testWithTopLeftBottomRightEdge() {
    var insets = UIEdgeInsets.zero
    
    insets = insets.with(top: 5)
    XCTAssertEqual(insets.top, 5)
    
    insets = insets.with(left: -5)
    XCTAssertEqual(insets.left, -5)
    
    insets = insets.with(bottom: 0)
    XCTAssertEqual(insets.bottom, 0)
    
    insets = insets.with(right: 9)
    XCTAssertEqual(insets.right, 9)
  }
}
