//
//  URLRouter.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/19.
//

import Foundation

final class URLRouter {
    
    private lazy var routes: [URL: ProviderEntryProtocol] = [:]
    
    private let lock: SpinLock = SpinLock()
    
    subscript(url: URL) -> ProviderEntryProtocol? {
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
        let entry = ProviderEntry(serviceType: ServiceProvider.self, argumentsType: Arguments.self, factory: factory)
        guard let key = url.asURL  else { return nil }
        self[key] = entry
        return entry
    }
    
    func unregister(url: URLConvertible) -> ProviderEntryProtocol? {
        guard let key = url.asURL else { return nil }
        guard let entry = self[key] else { return nil }
        self[key] = nil
        return entry
    }
    
    fileprivate func handle<ServiceProvider: ServiceProviderProtocol, Factory>(_ key: URL, serviceType: ServiceProvider.Type, invoke: @escaping (Factory) -> ServiceProvider) -> ServiceProvider? {
        var service: ServiceProvider?
        if let entry = self[key] {
            service = invoke(entry.factory as! Factory)
        }
        return service
    }
}

extension URLRouter {
    @discardableResult
    func canOpenURL(url: String) -> Bool {
        guard let key = url.asURL else { return false }
        guard let entry = self[key] else { return false }
        return entry.factory != nil
    }
}

extension URLRouter: URLResolver {
    
    func resolve<ServiceProvider: ServiceProviderProtocol>(serviceType: ServiceProvider.Type, url: URLConvertible) -> ServiceProvider? {
        guard let url = url.asURL else { return nil }
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        let parameters = urlComponents.queryItems?.reduce([String:String]()) {
            var dict = $0
            if let value = $1.value {
                dict[$1.name] = value
            }
            return dict
        } ?? [:]
        return handle(url, serviceType: serviceType) { (factory: ((URLResolver, [String: String])) -> ServiceProvider) -> ServiceProvider in
            return factory((self, parameters))
        }
    }
    
}
