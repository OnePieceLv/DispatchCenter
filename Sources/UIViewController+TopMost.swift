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
    private class var sharedApplication: UIApplication? {
        let selector = NSSelectorFromString("sharedApplication")
        return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
    }
    
    /// Returns the current application's top most view controller.
    open class var topMost: UIViewController? {
      guard let currentWindows = self.sharedApplication?.windows else { return nil }
      var rootViewController: UIViewController?
      for window in currentWindows {
        if let windowRootViewController = window.rootViewController, window.isKeyWindow {
          rootViewController = windowRootViewController
          break
        }
      }

        return self.topMost(of: rootViewController!)
    }
    
    open class func topMost(of viewController: UIViewController) -> UIViewController? {
        /// presented view controller
        if let presentedViewController = viewController.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        /// tabbar view controller
        if let tabbarController = viewController as? UITabBarController {
            if let selectedViewController = tabbarController.selectedViewController {
                return self.topMost(of: selectedViewController)
            }
        }
        
        /// navigation view controller
        if let navigationController = viewController as? UINavigationController {
            if let visibleViewController = navigationController.visibleViewController {
                return self.topMost(of: visibleViewController)
            }
        }
        
        /// page view controller
        if let pageViewController = (viewController as? UIPageViewController), pageViewController.viewControllers?.count == 1 {
            if let topViewController = pageViewController.viewControllers?.first {
                return self.topMost(of: topViewController)
            }
        }
        
        /// sub controller in view controller
        for subView in viewController.view.subviews {
            if let subViewController = subView.next as? UIViewController {
                return self.topMost(of: subViewController)
            }
        }
        
        return viewController
    }
}

#endif
