//
//  UIViewController+TopMost.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/20.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit

@available(iOS 8.0, tvOS 9.0, *)
extension UIViewController {
    private class var sharedApp: UIApplication? {
        let selector = NSSelectorFromString("sharedApplication")
        return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
    }
    
    /// Returns the current application's top most view controller.
    open class var topHead: UIViewController? {
      guard let currentWindows = self.sharedApp?.windows else { return nil }
      var rootViewController: UIViewController?
      for window in currentWindows {
        if let windowRootViewController = window.rootViewController, window.isKeyWindow {
          rootViewController = windowRootViewController
          break
        }
      }

        return self.topHead(of: rootViewController!)
    }
    
    open class func topHead(of viewController: UIViewController) -> UIViewController? {
        /// presented view controller
        if let presentedViewController = viewController.presentedViewController {
            return self.topHead(of: presentedViewController)
        }
        
        /// tabbar view controller
        if let tabbarController = viewController as? UITabBarController {
            if let selectedViewController = tabbarController.selectedViewController {
                return self.topHead(of: selectedViewController)
            }
        }
        
        /// navigation view controller
        if let navigationController = viewController as? UINavigationController {
            if let visibleViewController = navigationController.visibleViewController {
                return self.topHead(of: visibleViewController)
            }
        }
        
        /// page view controller
        if let pageViewController = (viewController as? UIPageViewController), pageViewController.viewControllers?.count == 1 {
            if let topViewController = pageViewController.viewControllers?.first {
                return self.topHead(of: topViewController)
            }
        }
        
        /// sub controller in view controller
        for subView in viewController.view.subviews {
            if let subViewController = subView.next as? UIViewController {
                return self.topHead(of: subViewController)
            }
        }
        
        return viewController
    }
}

#endif
