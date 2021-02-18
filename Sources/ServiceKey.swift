//
//  ServiceKey.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/16.
//

import Foundation

public struct ServiceKeyOption {
    let option: Int
}

extension ServiceKeyOption: Hashable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.option == rhs.option
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(option)
    }
}

public struct ServiceKey {
    let serviceType: Any.Type
    let argumentsType: Any.Type
    let name: String?
    let option: ServiceKeyOption? //Used for Storyboard or other extension
    
    init(serviceType: Any.Type,
         argumentsType: Any.Type,
         name: String? = nil,
         option: ServiceKeyOption? = nil
    ) {
        self.serviceType = serviceType
        self.argumentsType = argumentsType
        self.name = name
        self.option = option
    }
    
}

extension ServiceKey: Hashable {
    public static func == (lhs: ServiceKey, rhs: ServiceKey) -> Bool {
        return (lhs.serviceType == rhs.serviceType)
            && (lhs.argumentsType == rhs.argumentsType)
            && (lhs.name == rhs.name)
            && (lhs.option == rhs.option)
    }
    
    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(serviceType).hash(into: &hasher)
        ObjectIdentifier(argumentsType).hash(into: &hasher)
        name?.hash(into: &hasher)
        option?.hash(into: &hasher)
    }
}
