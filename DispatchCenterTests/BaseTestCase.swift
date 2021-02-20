//
//  BaseTestCase.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/18.
//

import XCTest
@testable import DispatchCenter

class Animate: ServiceProviderProtocol {
    
    let name: String
    
    required init<Arguments>(_ arguments: Arguments) {
        self.name = arguments as! String
    }
}

class Dog: ServiceProviderProtocol {
    
    convenience init(_ parameter: [String : Any]) {
        let age = parameter["age"] as? Int ?? 3
        let name = parameter["name"] as? String ?? "xx"
        let arguments = (name: name, age: age)
//        let arguments = (age: age, name: name) // ❌ Tuple 类型的顺序是有要求的，不然 type cast 会失败
        self.init(arguments)
    }
    
    required init<Arguments>(_ arguments: Arguments) {
        guard let params = arguments as? (name: String, age: Int) else {
            fatalError("arguments should be tuple type")
        }
        
        self.name = params.name
        self.age = params.age
    }
    
    let name: String
    let age: Int
    
    
//    required init(_ params: [String: Any]) {
//        self.age = params["age"] as? Int ?? 3
//        self.name = params["name"] as? String ?? "xx"
//    }
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
