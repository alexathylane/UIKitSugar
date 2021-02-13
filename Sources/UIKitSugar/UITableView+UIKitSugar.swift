import UIKit

public extension UITableView {
  // MARK: - Registration
  
  /// Registers the cell type with the implicit reuse identifer.
  func registerTypedCell<T: UITableViewCell>(_ cellClass: T.Type) {
    register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
  }
  
  /// Registers the view type with the implicit reuse identifer.
  func registerTypedHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
    register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.reuseIdentifier)
  }
  
  // MARK: - Dequeueing
  
  /// Dequeues the cell using the implicit reuse identifier, and type-checks it for you.
  /// - Warning: This will fatalError if the cell wasn't properly registered.
  func dequeueTypedReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    return dequeueTypedReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
  }
  
  /// Dequeues the cell and type-checks it for you.
  /// - Warning: This will fatalError if the cell wasn't properly registered.
  func dequeueTypedReusableCell<T: UITableViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
      fatalError("unable to dequeue cell of proper type \(String(describing: T.self)) with identifier \(identifier)")
    }
    return cell
  }
  
  /// Dequeues the view using the implicit reuse identifier, and type-checks it for you.
  /// - Warning: This will fatalError if the view wasn't properly registered.
  func dequeueTypedReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
    return dequeueTypedReusableHeaderFooterView(withIdentifier: T.reuseIdentifier)
  }
  
  /// Dequeues the view and type-checks it for you.
  /// - Warning: This will fatalError if the view wasn't properly registered.
  func dequeueTypedReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier identifier: String) -> T {
    guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
      fatalError("unable to dequeue view of proper type \(String(describing: T.self)) with identifier \(identifier)")
    }
    return view
  }
}

public extension UITableViewCell {
  /// An implicit reuse identifier
  static var reuseIdentifier: String { return String(describing: self) }
}

public extension UITableViewHeaderFooterView {
  /// An implicit reuse identifier
  static var reuseIdentifier: String { return String(describing: self) }
}
