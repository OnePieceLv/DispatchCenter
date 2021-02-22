//
//  ServiceProviderManager.swift
//  DispatchCenter-iOSDemo
//
//  Created by steven on 2021/2/23.
//

import Foundation
import DispatchCenter

final class Navigator: NavigatorType {}

let container = ServiceManager()

let navigator = Navigator()

extension CourseViewController: ServiceProviderProtocol {
    static func create(_ arguments: [String : Any]? = nil) -> Self {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let instance = storyboard.instantiateViewController(identifier: "CourseViewController") as! Self
        return instance
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
    static func create(_ arguments: [String : Any]? = nil) -> LessonViewController {
        let lesson = LessonViewController(nibName: "LessonViewController", bundle: nil)
        return lesson
    }
}
