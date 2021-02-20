//
//  ServiceManager+URLRouter.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/19.
//

import Foundation

extension ServiceManager {
    
    @discardableResult
    func register<ServiceProvider: ServiceProviderProtocol>(url: String, factory: @escaping ((URLResolver) -> ServiceProvider)) -> ProviderEntry<ServiceProvider>? {
        return urlRouter.register(url: url, factory: factory)
    }
    
    @discardableResult
    func register<ServiceProvider: ServiceProviderProtocol, Arguments>(url: String, factory: @escaping ((URLResolver, Arguments) -> ServiceProvider)) -> ProviderEntry<ServiceProvider>? {
        return urlRouter.register(url: url, factory: factory)
    }
}

extension ServiceManager {
    
    public func openURL<ServiceProvider: ServiceProviderProtocol, Arguments>(url: URLConvertible, serviceType: ServiceProvider.Type, arguments: Arguments) -> ServiceProvider? {
        
        return self.urlRouter.resolve(serviceType: serviceType, url: url, arguments: arguments)
    }
    
    public func openURL<ServiceProvider: ServiceProviderProtocol>(url: URLConvertible, serviceType: ServiceProvider.Type) -> ServiceProvider? {
        return self.urlRouter.resolve(serviceType: serviceType, url: url)
    }
}
