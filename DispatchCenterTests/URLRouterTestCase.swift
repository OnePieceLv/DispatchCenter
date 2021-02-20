//
//  URLRouterTestCase.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/19.
//

import XCTest
@testable import DispatchCenter

class URLRouterTestCase: BaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithURLString() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let url = "http://animate"
        container.register(url: url) { (_) -> Dog in
            let dog = Dog.init(["name": "lv", "age": 1])
            return dog
        }
        
        let dog = container.resolve(serviceType: Dog.self, url: url)
        XCTAssertNotNil(dog)
        
        XCTAssertEqual(dog?.name, "lv")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
