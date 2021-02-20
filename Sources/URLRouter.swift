//
//  URLRouter.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/19.
//

import Foundation

final class URLRouter {
    
    private lazy var routes: [String: ProviderEntryProtocol] = [:]
    
    private let lock: SpinLock = SpinLock()
    
    subscript(url: String) -> ProviderEntryProtocol? {
        get { lock.sync { routes[url] } }
        set { lock.sync { routes[url] = newValue } }
    }
    
    func register<ServiceProvider: ServiceProviderProtocol, Arguments>(url: String, factory: @escaping ((URLResolver,Arguments) -> ServiceProvider)) -> ProviderEntry<ServiceProvider>? {
        return _register(url: url, factory: factory)

    }
    
    func register<ServiceProvider: ServiceProviderProtocol>(url: String, factory: @escaping ((URLResolver) -> ServiceProvider)) -> ProviderEntry<ServiceProvider>? {
        
        return _register(url: url, factory: factory)
    }
    
    fileprivate func _register<ServiceProvider: ServiceProviderProtocol, Arguments>(url: String, factory: @escaping ((Arguments) -> ServiceProvider)) -> ProviderEntry<ServiceProvider>? {
        let key = url
        let entry = ProviderEntry(serviceType: ServiceProvider.self, argumentsType: Arguments.self, factory: factory)
        self[key] = entry
        return entry
    }
    
    func unregister(url: URLConvertible) -> ProviderEntryProtocol? {
        let key = url.asString
        let entry = self[key]
        if entry != nil {
            self[key] = nil
        }
        return entry
    }
    
    fileprivate func handle<ServiceProvider: ServiceProviderProtocol, Factory>(_ convertible: URLConvertible, serviceType: ServiceProvider.Type, factory: @escaping (Factory) -> ServiceProvider) -> ServiceProvider? {
        var service: ServiceProvider?
        if let entry = self[convertible.asString] {
            service = factory(entry.factory as! Factory)
        }
        return service
    }
}

extension URLRouter {
    @discardableResult
    func canOpenURL(url: String) -> Bool {
        let entry = self[url]
        return entry != nil && entry?.serviceType != nil && entry?.factory != nil
    }
}

extension URLRouter: URLResolver {
    
    func resolve<ServiceProvider: ServiceProviderProtocol>(serviceType: ServiceProvider.Type, url: URLConvertible) -> ServiceProvider? {
        return handle(url, serviceType: serviceType) { (factory: (URLResolver) -> ServiceProvider) -> ServiceProvider in
            return factory(self)
        }
    }
    
    func resolve<ServiceProvider: ServiceProviderProtocol, Arguments>(serviceType: ServiceProvider.Type, url: URLConvertible, arguments: Arguments) -> ServiceProvider? {
        typealias Factory = ((URLResolver, Arguments)) -> ServiceProvider
        return handle(url, serviceType: serviceType) { (factory: Factory) -> ServiceProvider in
            return factory((self, arguments))
        }
    }
}
