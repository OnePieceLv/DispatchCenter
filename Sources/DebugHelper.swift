//
//  DebugHelper.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/19.
//

import Foundation

protocol DebugHelper {
    func logging<Service: ServiceProviderProtocol, Arguments>(
        serviceType: Service.Type,
        argumentsType: Arguments.Type,
        key: ServiceKey,
        availableRegisters: [ServiceKey: ProviderEntryProtocol]
    )
}

struct LoggingHelper: DebugHelper {
    func logging<Service, Arguments>(serviceType: Service.Type, argumentsType: Arguments.Type, key: ServiceKey, availableRegisters: [ServiceKey : ProviderEntryProtocol]) where Service : ServiceProviderProtocol {
        let decriptionClosure: (_ serviceType: Any.Type, _ argumentsType: Any.Type, _ key: ServiceKey) -> String = { (serviceType, argumentsType, key) -> String in
            return (
                """
                Service: \(serviceType),Name: \(key.name ?? "nil"),Factory: \(argumentsType) -> \(key.serviceType)
                """
            )
        }
        var output = [
            "DispatchCenter: Resolve failed. Expected registes:",
            "\t{ \(decriptionClosure(serviceType, argumentsType, key)) }",
            "Avalidable Registers:",
        ]
        
        output += availableRegisters
            .filter({ $0.value is ProviderEntry<Service> })
            .compactMap({ (key: $0.key, value: ($0.value as? ProviderEntry<Service>)) })
            .map({
                let serviceKey: ServiceKey = $0.key
                if let value: ProviderEntry<Service> = $0.value {
                    return "\t{ \(decriptionClosure(value.serviceType, value.argumentsType, serviceKey)) }"
                } else {
                    return "nil"
                }
                
            })
                     
        print(output.joined(separator: "\n"))
    }
    
    
}
