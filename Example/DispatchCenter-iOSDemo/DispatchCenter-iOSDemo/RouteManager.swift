//
//  ServiceProviderManager.swift
//  DispatchCenter-iOSDemo
//
//  Created by steven on 2021/2/23.
//

import Foundation
import DispatchCenter

final class RouteManager: NavigatorType {
    
    static let `default`: RouteManager = RouteManager()
    
    let container: ServiceManager = ServiceManager()
}


extension CourseViewController: ServiceProviderProtocol {
    static func create(_ arguments: [String : Any]? = nil) -> Self {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let instance = storyboard.instantiateViewController(identifier: "CourseViewController") as? CourseViewController
        instance?.id = (arguments?["id"] as? Int)
        return instance as! Self
    }
}

extension SchoolViewController: ServiceProviderProtocol {
    static func create(_ arguments: [String : Any]? = nil) -> Self {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let instance = storyboard.instantiateViewController(identifier: "SchoolViewController") as! Self
        return instance
    }
}


extension LessonViewController: ServiceProviderProtocol {
    static func create(_ arguments: [String : Any]? = nil) -> Self {
        let lesson = LessonViewController(nibName: "LessonViewController", bundle: nil) as! Self
        guard let id = arguments?["id"] as? Int else {
            return lesson
        }
        lesson.id = id
        return lesson
    }
}
