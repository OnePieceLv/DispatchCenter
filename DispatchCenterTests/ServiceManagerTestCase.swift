//
//  ResolveTestCase.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/18.
//

import XCTest
@testable import DispatchCenter


class ServiceManagerTestCase: BaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testResolveWithArguments() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        container.register(Animate.self) { (container: Resolver) -> Animate in
            let animate = Animate.init(["name":"pet"])
            return animate
        }
        
        let animate = container.resolve(Animate.self)
        
        XCTAssertNotNil(animate)
        XCTAssertEqual(animate?.name, "pet")
    }
    
    func testResolveWithTupleArguments() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        container.register(Dog.self) { (container, arguments: (name: String, age: Int)) -> Dog in
            let animate = Dog(["name": arguments.name, "age": arguments.age])
            return animate
        }
        
        let animate = container.resolve(Dog.self, arguments: (name: "lion", age: 2))

        XCTAssertNotNil(animate)
        XCTAssertEqual(animate?.name, "lion")
        XCTAssertEqual(animate?.age, 2)
        XCTAssertNotEqual(animate?.age, 3)
    }
    
    func testResolveWithDictionaryArguments() throws {
        container.register(Dog.self) { (_, parameters: [String: Any]) -> Dog in
            return Dog.init(parameters)
        }
        
        let dog = container.resolve(Dog.self, arguments: ["name": "cat", "age": 2])
        XCTAssertNotNil(dog)
        XCTAssertEqual(dog?.name, "cat")
        XCTAssertEqual(dog?.age, 2)
        XCTAssertNotEqual(dog?.age, 3)
        XCTAssertNotEqual(dog?.name, "xx")

    }
    
    func testResolveLoggingFailed() throws {
        container.register(Dog.self) { (_, parameters: [String: String]) -> Dog in
            return Dog.init(parameters)
        }
        
        let dog = container.resolve(Dog.self, arguments: ["name": "cat", "age": 2])
        XCTAssertNil(dog)

    }
    
    func testWithUnRegisterAll() throws {
        let container = ServiceManager()
        container.register(Dog.self) { (container) -> Dog in
            return Dog()
        }
        
        container.unRegisterAll()
        
        
        let dog = container.resolve(Dog.self)
        
        XCTAssertNil(dog)
        
    }
    
    

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
