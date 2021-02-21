//
//  Provider.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/16.
//

import Foundation

public protocol ServiceProviderProtocol {
    init(_ arguments: [String:Any]?)
}

public protocol URLConvertible {
    var asURL: URL? { get }
}

extension String: URLConvertible {
    public var asURL: URL? {
        return URL(string: self)
    }
    
}

//extension URL: URLConvertible {
//
//    public var asURL: URL? {
//        return  self
//    }
//}
