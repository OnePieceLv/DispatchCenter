//
//  Provider.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/16.
//

import Foundation

public protocol ServiceProviderProtocol: AnyObject {
    init<Arguments>(_ arguments: Arguments)
}

extension ServiceProviderProtocol {
    
    init<Arguments>(_ arguments: Arguments) {
        fatalError("should be implements require init")
    }

}
