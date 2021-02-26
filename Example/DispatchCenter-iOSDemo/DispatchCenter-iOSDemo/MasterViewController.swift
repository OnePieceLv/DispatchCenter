//
//  ViewController.swift
//  DispatchCenter-iOSDemo
//
//  Created by steven on 2021/2/22.
//

import UIKit

let url = "dispatch://course/lesson?id=1"

class MasterViewController: UITableViewController {
    
    let data: [String] = ["课程","学校", "present", "push", "show"]
    
//    let container: ServiceManager = ServiceManager()
//    let navigator: Navigator = Navigator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let container = RouteManager.default.container
        container.register(CourseViewController.self) { (_, id: Int) -> CourseViewController in
            let course = CourseViewController.create(["id": id])
            return course
        }
        
        container.register(SchoolViewController.self) { (_) -> SchoolViewController in
            let school = SchoolViewController.create()
            return school
        }
        
        let registerUrl = "dispatch://course/lesson"
        container.register(url: registerUrl) { (_, parameter: [String: String]?) -> LessonViewController in
            var arguments: [String: Any] = [:]
            if let idstr = parameter?["id"], let id = Int(idstr) {
                arguments["id"] = id
            }
            let lesson = LessonViewController.create(arguments)
            return lesson
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.segue(name: data[indexPath.row])
    }
    
    func segue(name:String) -> Void {
        let navigator = RouteManager.default
        let container = navigator.container
        switch name {
        case "课程":
            let course = container.resolve(CourseViewController.self, arguments: 1)!
            navigator.showViewController(course, from: self)
        case "学校":
            let school = container.resolve(SchoolViewController.self)!
            navigator.pushViewController(school, animated: false)
        case "present":
            
            navigator.presentURL(url, controllerType: LessonViewController.self, container: container, animated: true) {
                print("present")
            }
        case "push":
            navigator.pushURL(url, controllerType: LessonViewController.self, container: container, animated: true)
        case "show":
            navigator.showURL(url, controllerType: LessonViewController.self, container: container)
        default: break
        }
    }
}

