//
//  Navigator.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/20.
//

import Foundation

#if os(iOS) || os(tvOS)

import UIKit

public protocol UINavigationControllerType {
    func show(_ vc: UIViewController, sender: Any?)
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

public protocol UIViewControllerType {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func show(_ vc: UIViewController, sender: Any?)
    func showDetailViewController(_ vc: UIViewController, sender: Any?)
    
    var splitViewController: UISplitViewController? { get }
    var modalPresentationStyle: UIModalPresentationStyle { get set }
    var modalTransitionStyle: UIModalTransitionStyle { get set }
    
}

extension UINavigationController: UINavigationControllerType {}
extension UIViewController: UIViewControllerType {}

@available(iOS 8.0, tvOS 9.0, *)
public protocol NavigatorType {
    
    @discardableResult
    func pushURL<ViewController: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: ViewController.Type, from sender: UINavigationControllerType?, container: ServiceManager, animated: Bool) -> ViewController?
    
    @discardableResult
    func pushViewController<ViewController: UIViewController & ServiceProviderProtocol>(_ viewController: ViewController, from sender: UINavigationControllerType?, animated: Bool) -> ViewController?
    
    @discardableResult
    func presentURL<ViewController: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: ViewController.Type, from sender: UIViewControllerType?, underNav: Bool, container: ServiceManager, animated: Bool, completion: (() -> Void)?) -> ViewController?
    
    @discardableResult
    func presentViewController<ViewController: UIViewController & ServiceProviderProtocol>(_ viewController: ViewController, from sender: UIViewControllerType?, underNav: Bool, animated: Bool, completion: (() -> Void)?) -> ViewController?

    
    @discardableResult
    func showURL<ViewController: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: ViewController.Type, from sender: UIViewControllerType?, underNav: Bool, container: ServiceManager) -> ViewController?
    
    @discardableResult
    func showViewController<ViewController: UIViewController & ServiceProviderProtocol>(_ viewController: ViewController, from sender: UIViewControllerType?, underNav: Bool) -> ViewController?
    
    @discardableResult
    func showDetailURL<DetailViewController: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: DetailViewController.Type, from sender: UIViewControllerType?, container: ServiceManager) -> DetailViewController?
    
    @discardableResult
    func showDetailController<DetailViewController: UIViewController & ServiceProviderProtocol>(_ detailViewController: DetailViewController, from sender: UIViewControllerType?) -> DetailViewController?

    
}

public extension NavigatorType {
    
    @discardableResult
    func pushURL<ViewController: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: ViewController.Type, from sender: UINavigationControllerType? = nil, container: ServiceManager, animated: Bool) -> ViewController? {
        if let viewContoller = container.openURL(url: url, serviceType: controllerType) {
            return self.pushViewController(viewContoller, from: sender, animated: animated)
        }
        return nil
    }
    
    @discardableResult
    func pushViewController<ViewController: UIViewController & ServiceProviderProtocol>(_ viewController: ViewController, from sender: UINavigationControllerType? = nil, animated: Bool) -> ViewController? {
        guard let navigationController = (sender ?? UIViewController.topHead?.navigationController) else { return nil }
        navigationController.pushViewController(viewController, animated: animated)
        return viewController
    }
    
    
    @discardableResult
    func presentURL<ViewController: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: ViewController.Type, from sender: UIViewControllerType? = nil, underNav: Bool = false, container: ServiceManager, animated: Bool, completion: (() -> Void)?) -> ViewController? {
        if let viewContoller = container.openURL(url: url, serviceType: controllerType) {
            return self.presentViewController(viewContoller, from: sender, underNav: underNav, animated: animated, completion: completion)
        }
        return nil
    }
    
    @discardableResult
    func presentViewController<ViewController: UIViewController & ServiceProviderProtocol>(_ viewController: ViewController, from sender: UIViewControllerType? = nil, underNav: Bool, animated: Bool, completion: (() -> Void)?) -> ViewController?{
        guard let vc = sender ?? UIViewController.topHead else { return nil }
        if underNav {
            let nav = UINavigationController(rootViewController: viewController)
            vc.present(nav, animated: animated, completion: completion)
        } else {
            vc.present(viewController, animated: animated, completion: completion)
        }
        return viewController
    }
    
    
    @discardableResult
    func showURL<ViewController: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: ViewController.Type, from sender: UIViewControllerType? = nil, underNav: Bool = false, container: ServiceManager) -> ViewController? {
        if let viewContoller = container.openURL(url: url, serviceType: controllerType) {
            return self.showViewController(viewContoller, from: sender, underNav: underNav)
        }
        return nil
    }
    

    @discardableResult
    func showViewController<ViewController: UIViewController & ServiceProviderProtocol>(_ viewController: ViewController, from sender: UIViewControllerType? = nil, underNav: Bool) -> ViewController? {
        guard let vc =  sender ?? UIViewController.topHead else { return nil }
        if underNav {
            let nav = UINavigationController(rootViewController: viewController)
            vc.show(nav, sender: vc)
        } else {
            
            vc.show(viewController, sender: vc)
        }
        return viewController
    }
    
    @discardableResult
    func showDetailURL<DetailViewController: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: DetailViewController.Type, from sender: UIViewControllerType? = nil, container: ServiceManager) -> DetailViewController? {
        guard let detailViewController = container.openURL(url: url, serviceType: controllerType) else {
            return nil
        }
        return self.showDetailController(detailViewController, from: sender)
    }
    
    @discardableResult
    func showDetailController<DetailViewController: UIViewController & ServiceProviderProtocol>(_ detailViewController: DetailViewController, from sender: UIViewControllerType? = nil) -> DetailViewController? {
        guard let master = sender ?? UIViewController.topHead else { return nil }
        guard master.splitViewController != nil else { return nil }
        master.showDetailViewController(detailViewController, sender: master)
        return detailViewController
    }

}

#endif

