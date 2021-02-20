//
//  ServiceManager.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/16.
//

import Foundation

public final class ServiceManager {
    
    private var services: [ServiceKey: ProviderEntryProtocol] = [:]
    
    private let logger: DebugHelper = LoggingHelper()
    
    let urlRouter: URLRouter = URLRouter()
        
    private let lock: SpinLock = SpinLock()
    
    subscript(key: ServiceKey) -> ProviderEntryProtocol? {
        get {
            lock.sync { services[key] }
        }
        set {
            lock.sync { services[key] = newValue }
        }
    }
    
    func unRegisterAll() -> Void {
        services.removeAll()
    }
    
    deinit {
        unRegisterAll()
    }
    
    @discardableResult
    func register<ServiceProvider: ServiceProviderProtocol>(_ serviceType: ServiceProvider.Type, name: String? = nil, factory: @escaping ((Resolver) -> ServiceProvider)) -> ProviderEntry<ServiceProvider> {
        return _register(serviceType, factory: factory, name: name, option: nil)
    }
    
    @discardableResult
    func register<ServiceProvider: ServiceProviderProtocol, Arguments>(_ serviceType: ServiceProvider.Type, name: String? = nil, factory: @escaping ((Resolver,Arguments) -> ServiceProvider)) -> ProviderEntry<ServiceProvider> {
        return _register(serviceType, factory: factory, name: name, option: nil)
    }
    
    @discardableResult
    func register<ServiceProvider: ServiceProviderProtocol>(_ serviceType: ServiceProvider.Type, name: String? = nil, factory: @escaping ((Resolver, Dictionary<String, Any>) -> ServiceProvider)) -> ProviderEntry<ServiceProvider> {
        return _register(serviceType, factory: factory, name: name, option: nil)
    }
    
   fileprivate func _register<ServiceProvider: ServiceProviderProtocol, Arguments>(
        _ serviceType: ServiceProvider.Type,
        factory: @escaping (Arguments) -> Any,
        name: String? = nil,
        option: ServiceKeyOption? = nil
    ) -> ProviderEntry<ServiceProvider> {
        let key = ServiceKey(serviceType: serviceType, argumentsType: Arguments.self, name: name, option: option)
        let entry = ProviderEntry(serviceType: serviceType, argumentsType: Arguments.self, factory: factory)
        self[key] = entry
        return entry
    }
    
}

extension ServiceManager: _Resolver {
    func _resolve<ServiceProvider: ServiceProviderProtocol, Arguments>(
        name: String? = nil,
        option: ServiceKeyOption? = nil,
        factory: @escaping ((Arguments) -> Any) -> Any
    ) -> ServiceProvider? {
        var service: ServiceProvider? = nil
        let key = ServiceKey(serviceType: ServiceProvider.self, argumentsType: Arguments.self, name: name, option: option)
        let entry = self[key]
        if let entryProvider = entry {
            service = resolveFactory(entry: entryProvider, invoke: factory)
        }
        if service == nil {
            logger.logging(serviceType: ServiceProvider.self, argumentsType: Arguments.self, key: key, availableRegisters: self.services)
        }
        return service
    }
    
    fileprivate func resolveFactory<ServiceProvider: ServiceProviderProtocol, Factory>(
        entry: ProviderEntryProtocol,
        invoke: @escaping (Factory) -> Any
        ) -> ServiceProvider? {
        return invoke(entry.factory as! Factory) as? ServiceProvider
    }
}


extension ServiceManager: Resolver {
    public func resolve<ServiceProvider>(_ service: ServiceProvider.Type) -> ServiceProvider? where ServiceProvider : ServiceProviderProtocol {
        return resolve(service, name: nil)
    }
    
    public func resolve<ServiceProvider>(_ service: ServiceProvider.Type, name: String?) -> ServiceProvider? where ServiceProvider : ServiceProviderProtocol {
        return _resolve(name: name) { (factory: (Resolver) -> Any) in
            factory(self)
        }
    }
    
    public func resolve<ServiceProvider, Arguments>(_ service: ServiceProvider.Type, arguments: Arguments) -> ServiceProvider? where ServiceProvider : ServiceProviderProtocol {
        return resolve(service, arguments: arguments, name: nil)
    }
    
    public func resolve<ServiceProvider, Arguments>(_ service: ServiceProvider.Type, arguments: Arguments, name: String?) -> ServiceProvider? where ServiceProvider : ServiceProviderProtocol {
        typealias Factory = ((Resolver, Arguments)) -> Any
        return _resolve(name: name) { (factory: Factory) -> Any in
            return factory((self, arguments))
        }
    }
    
    
    
}
