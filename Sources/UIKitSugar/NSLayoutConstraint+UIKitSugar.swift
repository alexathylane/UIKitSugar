import UIKit

public extension NSLayoutConstraint {
  /// Modifies and returns the receiver with the specified `priority`.
  func with(priority: UILayoutPriority) -> NSLayoutConstraint {
    self.priority = priority
    return self
  }
}

public extension UILayoutPriority {
  /// The greatest value less than `UILayoutPriority.required`.
  static let nearlyRequired = UILayoutPriority.required - 1
}
