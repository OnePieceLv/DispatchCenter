//
//  ServiceProviderTestCase.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/21.
//

import XCTest
@testable import DispatchCenter

class ServiceProviderTestCase: BaseTestCase {
    
    class Elephant: ServiceProviderProtocol {
        let name: String
        let age: Int
        required init(_ arguments: [String : Any]? = nil) {
            self.name = (arguments?["name"] as? String) ?? "大象"
            self.age = (arguments?["age"] as? Int) ?? 3
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithNotImplementInit() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let elephant = Elephant.init(["name": "daxiang", "age": 3])
        XCTAssertNotNil(elephant)
        XCTAssertEqual(elephant.name, "daxiang")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
