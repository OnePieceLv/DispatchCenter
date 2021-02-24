//
//  BaseTestCase.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/18.
//

import XCTest
@testable import DispatchCenter

class Animate: ServiceProviderProtocol {
    
    static func create(_ arguments: [String : Any]? = nil) -> Self {
        return self.init(arguments)
    }
    
    
    let name: String
    
    required init(_ arguments: [String: Any]? = nil) {
        self.name = (arguments?["name"] as? String) ?? ""
    }
    
    
}

class Dog: ServiceProviderProtocol {
    
    static func create(_ arguments: [String : Any]? = nil) -> Self {
        return self.init(arguments)

    }
    
    required init(_ parameter: [String : Any]? = nil) {
        self.age = (parameter?["age"] as? Int) ?? 3
        self.name = (parameter?["name"] as? String) ?? "xx"
    }
    
    let name: String
    let age: Int
    
    
//    required init(_ params: [String: Any]) {
//        self.age = params["age"] as? Int ?? 3
//        self.name = params["name"] as? String ?? "xx"
//    }
}

struct Rabbit: ServiceProviderProtocol {
    
    var id: Int?
    
    static func create(_ arguments: [String: Any]? = nil) -> Self {
        return Rabbit(id: (arguments?["id"] as? Int))
    }
}

class BaseTestCase: XCTestCase {
    
    var container: ServiceManager = ServiceManager()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
