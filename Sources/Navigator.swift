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
}

public protocol UIViewControllerType {
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
    func showURL<UIViewControllerType: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: UIViewControllerType.Type, from sender: UIViewControllerType?, animated: Bool) -> UIViewControllerType?
    
    @discardableResult
    func showViewController<UIViewControllerType: UIViewController & ServiceProviderProtocol>(_ viewController: UIViewControllerType, from sender: UIViewControllerType?, animated: Bool) -> UIViewControllerType?
    
    @discardableResult
    func showDetailURL<DetailViewControllerType: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: DetailViewControllerType.Type, from sender: UIViewControllerType?, animated: Bool) -> DetailViewControllerType?
    
    @discardableResult
    func showDetailController<DetailViewControllerType: UIViewController & ServiceProviderProtocol>(_ detailViewController: DetailViewControllerType, from sender: UIViewControllerType?, animated: Bool) -> DetailViewControllerType?

    
}

extension NavigatorType {
    func showURL<UIViewControllerType: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: UIViewControllerType.Type, from sender: UIViewControllerType? = nil, animated: Bool) -> UIViewControllerType? {
        if let viewContoller = ServiceManager.init().openURL(url: url, serviceType: controllerType) {
            return self.showViewController(viewContoller, from: sender, animated: animated)
        }
        return nil
    }
    

    
    func showViewController<UIViewControllerType: UIViewController & ServiceProviderProtocol>(_ viewController: UIViewControllerType, from sender: UIViewControllerType? = nil, animated: Bool) -> UIViewControllerType? {
        guard let navigationController =  sender ?? UIViewControllerType.topMost else { return nil }
        if !animated {
            navigationController.modalPresentationStyle = .none
        }
        navigationController.show(viewController, sender: navigationController)
        return viewController
    }
    
    func showDetailURL<DetailViewControllerType: UIViewController & ServiceProviderProtocol>(_ url: URLConvertible, controllerType: DetailViewControllerType.Type, from sender: UIViewControllerType? = nil, animated: Bool) -> DetailViewControllerType? {
        guard let detailViewController = ServiceManager().openURL(url: url, serviceType: controllerType) else {
            return nil
        }
        return self.showDetailController(detailViewController, from: sender, animated: animated)
    }
    
    func showDetailController<DetailViewControllerType: UIViewController & ServiceProviderProtocol>(_ detailViewController: DetailViewControllerType, from sender: UIViewControllerType? = nil, animated: Bool) -> DetailViewControllerType? {
        guard var master = sender ?? UIViewController.topMost else { return nil }
        guard master.splitViewController != nil else { return nil }
        if !animated {
            master.modalPresentationStyle = .none
        }
        master.showDetailViewController(detailViewController, sender: master)
        return detailViewController
    }

}

#endif

