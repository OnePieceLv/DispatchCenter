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
        let url = "http://animate?name=li&age=1"
        
        container.register(url: url) { (resolve, parameter) -> Dog in
            guard let param = parameter else { return Dog([:]) }
            let name = param["name"]!
            let age = Int(param["age"]!)!
            let dog = Dog.init(["name": name, "age": age])
            return dog
        }
        
        let dog = container.openURL(url: url, serviceType: Dog.self)
        XCTAssertNotNil(dog)
        
        XCTAssertEqual(dog?.name, "li")
    }
    
    func testWithURL() throws {
        let urlStr = "http://animate?name=lv&age=1"
        let url = URL(string: urlStr)
        XCTAssertNotNil(url)
        XCTAssertEqual(url?.baseURL, nil)
        let urlStr2 = "http://nengxuehui.cn/animate?name=lv&age=1"
        let url2 = URL(string: urlStr2)
        XCTAssertEqual(url2?.host, "nengxuehui.cn")
        
        let baseURL = URL(string: "http://server/foo/")!
        let url3 = URL(string: "bar/file.html", relativeTo: baseURL)!
        XCTAssertEqual(url3.absoluteString, "http://server/foo/bar/file.html")
        let comp1 = URLComponents(url: url3, resolvingAgainstBaseURL: false)!
        XCTAssertEqual(comp1.string!, "bar/file.html")
        let comp2 = URLComponents(url: url3, resolvingAgainstBaseURL: true)!
        XCTAssertEqual(comp2.string!, "http://server/foo/bar/file.html")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testWithUnregister() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let url = "http://animate?name=li&age=1"
        let router = URLRouter.init()
        
        _ = router.register(url: url) { (resolver, parameter) -> Dog in
            guard let param = parameter else { return Dog([:]) }
            let name = param["name"]!
            let age = Int(param["age"]!)!
            let dog = Dog.init(["name": name, "age": age])
            return dog
        }
        
        _ = router.unregister(url: url)
        
        
        let dog = router.resolve(serviceType: Dog.self, url: url)
        XCTAssertNil(dog)
        
    }
    
    func testWithCanOpenURL() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let url = "http://animate?name=li&age=1"
        let router = URLRouter.init()
        
        _ = router.register(url: url) { (resolver, parameter) -> Dog in
            guard let param = parameter else { return Dog([:]) }
            let name = param["name"]!
            let age = Int(param["age"]!)!
            let dog = Dog.init(["name": name, "age": age])
            return dog
        }
        
        let isCan = router.canOpenURL(url: url)
        
        XCTAssertTrue(isCan)
        
    }

}
