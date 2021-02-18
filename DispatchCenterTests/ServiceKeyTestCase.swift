//
//  ServiceKeyTestCase.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/19.
//

import XCTest
@testable import DispatchCenter


class ServiceKeyTestCase: BaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithoutName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let key1 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self)
        let key2 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self)
        XCTAssertEqual(key1, key2)
        
        let key3 = ServiceKey(serviceType: Dog.self, argumentsType: Resolver.self)
        let key4 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self)
        XCTAssertNotEqual(key3, key4)
        
    }
    
    func testWitName() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let key1 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, name: "Animate")
        let key2 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, name: "Animate")
        XCTAssertEqual(key1, key2)
        
        let key3 = ServiceKey(serviceType: Dog.self, argumentsType: Resolver.self, name: "Animate")
        let key4 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, name: "Animate")
        XCTAssertNotEqual(key3, key4)
        
        let key5 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, name: "Animate")
        let key6 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, name: "other animate")
        XCTAssertNotEqual(key5, key6)
        
    }
    
    func testWithOption() throws {
        let key1 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, option: ServiceKeyOption(option: 1))
        let key2 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, option: ServiceKeyOption(option: 1))
        XCTAssertEqual(key1, key2)
        XCTAssertEqual(key1.hashValue, key2.hashValue)
        
        let key3 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, option: ServiceKeyOption(option: 2))
        let key4 = ServiceKey(serviceType: Animate.self, argumentsType: Resolver.self, option: ServiceKeyOption(option: 3))
        XCTAssertNotEqual(key3, key4)
        XCTAssertNotEqual(key3.hashValue, key4.hashValue)

    }
    
    func testWithArguments() throws {
        let key1 = ServiceKey(serviceType: Animate.self, argumentsType: (Resolver, String, Bool).self, option: ServiceKeyOption(option: 1))
        let key2 = ServiceKey(serviceType: Animate.self, argumentsType: (Resolver, String, Bool).self, option: ServiceKeyOption(option: 1))
        XCTAssertEqual(key1, key2)
        
        let key3 = ServiceKey(serviceType: Animate.self, argumentsType: (Resolver, Bool).self, option: ServiceKeyOption(option: 1))
        let key4 = ServiceKey(serviceType: Animate.self, argumentsType: (Resolver, String, Bool).self, option: ServiceKeyOption(option: 1))
        XCTAssertNotEqual(key3, key4)
        
        
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
