//
//  DebugHelperTests.swift
//  DispatchCenter
//
//  Created by steven on 2021/2/22.
//

import XCTest
@testable import DispatchCenter
private class Debuglogging: DebugHelper {
    
    var serviceType: Any = ""
    var key: ServiceKey?
    var availableRegistrations: [ServiceKey: ProviderEntryProtocol]?

    
    func logging<Service, Arguments>(serviceType: Service.Type, argumentsType: Arguments.Type, key: ServiceKey, availableRegisters: [ServiceKey : ProviderEntryProtocol]) where Service : ServiceProviderProtocol {
        self.serviceType = serviceType
        self.key = key
        self.availableRegistrations = availableRegisters
    }
}

class DebugHelperTests: BaseTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDebugloging() throws {
        let key = ServiceKey.init(serviceType: Dog.self, argumentsType: [String: Any].self)
        let logging = Debuglogging()
        logging.logging(serviceType: Dog.self, argumentsType: [String: Any].self, key: key, availableRegisters: [:])
        XCTAssertNotNil(logging.key)
        XCTAssertNotNil(logging.serviceType)
        XCTAssertTrue(logging.availableRegistrations!.isEmpty)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
