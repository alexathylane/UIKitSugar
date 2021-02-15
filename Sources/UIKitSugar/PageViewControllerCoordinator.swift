import UIKit

/// PageViewControllerCoordinator handles much of the boiler plate code for coordinating between a `UIPageViewController`,
/// its child view controllers, and a custom `UIPageControl`.
/// - Note: This class is only to be used for a simple case: paging betwen a static set of child view controllers
public class PageViewControllerCoordinator<T: UIViewController>: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  /// The child "pages" of the page view controller.
  public let viewControllers: [T]
  /// The page view controller to coordinate.
  public weak var pageViewController: UIPageViewController?
  /// The index of the current active page view controller.
  public var currentPage = 0
  
  private var customPageControl: UIPageControl?
  
  public init(viewControllers: [T], pageViewController: UIPageViewController) {
    self.viewControllers = viewControllers
    self.pageViewController = pageViewController
    super.init()
    pageViewController.delegate = self
    pageViewController.dataSource = self
  }
  
  /// Responds to user interaction of the `pageControl` and updates its state accordingly.
  public func installCustomPageControl(_ pageControl: UIPageControl) {
    customPageControl?.numberOfPages = viewControllers.count
    customPageControl?.currentPage = currentPage
    customPageControl?.addTarget(self, action: #selector(pageControlValueDidChange(_:)), for: .valueChanged)
  }
  
  @objc private func pageControlValueDidChange(_: UIPageControl) {
    guard let pageControl = customPageControl else { return }
    let selectedPage = pageControl.currentPage
    guard selectedPage != currentPage else { return }
    let vc = viewControllers[selectedPage]
    customPageControl?.isEnabled = false // disable (then re-enable) to handle users swiping / tapping quickly
    let direction: UIPageViewController.NavigationDirection = selectedPage > currentPage ? .forward : .reverse
    pageViewController?.setViewControllers([vc], direction: direction, animated: true, completion: { [weak self] completed in
      self?.currentPage = selectedPage
      self?.customPageControl?.isEnabled = true
    })
  }
  
  // MARK: UIPageViewControllerDataSource
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    let viewController = viewController as! T
    guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
    guard index > 0 && index < viewControllers.count else { return nil }
    return viewControllers[index - 1]
  }
  
  public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    let viewController = viewController as! T
    guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
    guard index >= 0 && index < (viewControllers.count - 1) else { return nil }
    return viewControllers[index + 1]
  }
  
  // MARK: UIPageViewControllerDelegate
  
  public func pageViewController(_ pageViewController: UIPageViewController,
                          didFinishAnimating finished: Bool,
                          previousViewControllers: [UIViewController],
                          transitionCompleted completed: Bool) {
    if completed,
       let firstPageViewController = pageViewController.viewControllers?.first,
       let firstPageIndex = viewControllers.firstIndex(of: firstPageViewController as! T) {
      currentPage = firstPageIndex
      customPageControl?.currentPage = currentPage
      customPageControl?.isEnabled = true // enable here to avoid disabled state when user swipes / taps quickly
    }
  }
}
