import UIKit

public extension UIRefreshControl {
    /// Sets an auto-timeout interval on the receiver. A "timeout" means the receiver will stop _visually_ refreshing after `timeout`.
    func setTimeout(_ timeout: TimeInterval) {
        let identifier = UIAction.Identifier("UIRefreshControl.timeout")
        removeAction(identifiedBy: identifier, for: .valueChanged)
        guard timeout > 0 else { return }
        
        let valueChangedHandler = UIAction(identifier: identifier) { _ in
            // TODO: Add better handling of timing of multiple overlapping requests.
            DispatchQueue.main.asyncAfter(deadline: .now() + timeout) { [weak self] in
                self?.endRefreshing()
            }
        }
        
        addAction(valueChangedHandler, for: .valueChanged)
    }
}

public extension UIAction {
    /// Creates a UIAction with an empty title, nil image, and the specified `identifier` & `handler`.
    /// - Returns: A new UIAction.
    convenience init(identifier: UIAction.Identifier, handler: @escaping UIActionHandler) {
        self.init(title: "",
                  image: nil,
                  identifier: identifier,
                  discoverabilityTitle: nil,
                  attributes: [],
                  state: .off,
                  handler: handler)
    }
}
