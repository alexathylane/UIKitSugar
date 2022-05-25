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
    
    // MARK: - Refreshing & loading states
    
    /// Adds a refresh control to the receiver with a timeout interval if specified.
    func addRefreshControl(_ refreshControl: UIRefreshControl, timeout: TimeInterval? = nil) {
        if let timeout = timeout {
            refreshControl.setTimeout(timeout)
        }
        self.refreshControl = refreshControl
        // Workaround for bug where refresh control is on top of table view
        refreshControl.layer.zPosition = -1
    }
    
    /// Adds a loading indicator to the receiver with the specified `style`.
    func addLoadingIndicator(_ style: UIActivityIndicatorView.Style) {
        let activityView = UIActivityIndicatorView(style: style)
        backgroundView = activityView
        activityView.startAnimating()
    }
    
    /// Removes any loading indicator if set on the receiver.
    func removeLoadingIndicator() {
        guard let _ = backgroundView as? UIActivityIndicatorView else { return }
        backgroundView = nil
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
