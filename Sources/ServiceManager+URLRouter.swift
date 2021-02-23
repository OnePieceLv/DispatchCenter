//
//  ServiceManager+URLRouter.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/19.
//

import Foundation

public extension ServiceManager {
    
    @discardableResult
    func register<ServiceProvider: ServiceProviderProtocol>(url: String, factory: @escaping ((URLResolver, [String: String]?) -> ServiceProvider)) -> ProviderEntry<ServiceProvider>? {
        return urlRouter.register(url: url, factory: factory)
    }
}

public extension ServiceManager {
    
    func openURL<ServiceProvider: ServiceProviderProtocol>(url: URLConvertible, serviceType: ServiceProvider.Type? = nil) -> ServiceProvider? {
        let service: ServiceProvider? = self.urlRouter.resolve(url: url, serviceType: serviceType)
        return service
    }
}
