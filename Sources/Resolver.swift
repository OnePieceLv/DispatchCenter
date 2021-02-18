//
//  Resolve.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/16.
//

import Foundation

public protocol Resolver {
    func resolve<ServiceProvider: ServiceProviderProtocol>(_ service: ServiceProvider.Type) -> ServiceProvider?
    func resolve<ServiceProvider: ServiceProviderProtocol>(_ service: ServiceProvider.Type, name: String?) -> ServiceProvider?
    func resolve<ServiceProvider: ServiceProviderProtocol, Arguments>(_ service: ServiceProvider.Type, arguments: Arguments) -> ServiceProvider?
    func resolve<ServiceProvider: ServiceProviderProtocol, Arguments>(_ service: ServiceProvider.Type, arguments: Arguments, name: String?) -> ServiceProvider?
}

protocol _Resolver {
    func _resolve<ServiceProvider: ServiceProviderProtocol, Arguments>(
        name: String?,
        option: ServiceKeyOption?,
        factory: @escaping ((Arguments) -> Any) -> Any
    ) -> ServiceProvider?
}
