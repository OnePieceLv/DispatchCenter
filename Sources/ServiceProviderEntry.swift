//
//  ProviderEntry.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/17.
//

import Foundation

public typealias FunctionType = Any

protocol ProviderEntryProtocol {
    var serviceType: Any.Type { get }
    var factory: FunctionType? { get }
}


final class ProviderEntry<ServiceProvider>: ProviderEntryProtocol {
    let serviceType: Any.Type
    let argumentsType: Any.Type
    let factory: FunctionType?
    weak var manager: ServiceManager?
    
    init(serviceType: ServiceProvider.Type, argumentsType: Any.Type, factory: FunctionType?) {
        self.serviceType = serviceType
        self.argumentsType = argumentsType
        self.factory = factory
    }
    
    
}
