//
//  Provider.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/16.
//

import Foundation

public protocol ServiceProviderProtocol {
    init<Arguments>(_ arguments: Arguments)
}

extension ServiceProviderProtocol {
    
    init<Arguments>(_ arguments: Arguments) {
        fatalError("should be implements require init")
    }

}

public protocol URLConvertible {
    var asURL: URL? { get }
    var asString: String { get }
}

extension String: URLConvertible {
    public var asURL: URL? {
        return URL(string: self)
    }
    
    public var asString: String {
        return self
    }
}

extension URL: URLConvertible {
    public var asString: String {
        return self.absoluteString
    }
    
    public var asURL: URL? {
        return  self
    }
}
