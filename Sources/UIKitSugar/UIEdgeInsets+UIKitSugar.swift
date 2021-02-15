import UIKit

public extension UIEdgeInsets {
  /// Returns a copy of the receiver with the specified `top` inset.
  func with(top: CGFloat) -> UIEdgeInsets {
    var insets = self
    insets.top = top
    return insets
  }
  
  /// Returns a copy of the receiver with the specified `left` inset.
  func with(left: CGFloat) -> UIEdgeInsets {
    var insets = self
    insets.left = left
    return insets
  }
  
  /// Returns a copy of the receiver with the specified `bottom` inset.
  func with(bottom: CGFloat) -> UIEdgeInsets {
    var insets = self
    insets.bottom = bottom
    return insets
  }
  
  /// Returns a copy of the receiver with the specified `right` inset.
  func with(right: CGFloat) -> UIEdgeInsets {
    var insets = self
    insets.right = right
    return insets
  }
}
