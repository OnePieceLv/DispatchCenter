# DispatchCenter

![logo](https://raw.githubusercontent.com/OnePieceLv/DispatchCenter/main/images/cover.png)

# What problem is DispatchCenter trying to solve?

When an app becomes more and more complex, there is a lot of dependencies on business modules, like this:

<img src="https://raw.githubusercontent.com/OnePieceLv/DispatchCenter/main/images/readme/dependencies-bs.svg" alt="dependencies-bs" width="400" height="300">

With the DispatchCenter architecture, we hope to achieve clear module responsibilities and boundaries, improve code quality, reduce complex dependencies, improve development efficiency, and make it easy to identify problems. like this：

<img src="https://raw.githubusercontent.com/OnePieceLv/DispatchCenter/main/images/readme/mediator-bs.svg" alt="mediator-bs" width="400" height="300">

# Feature

- [x]  Service Register With Generic Type or URL
- [x]  Support Resolve Service With Complex Parameter
- [x]  Support URL query parameter
- [x]  Support Reference and Value Type
- [x]  Support push/present/show/showdetail navigation
- [x]  Support Navigation With URL or ViewController

# Requirements

- iOS 9.0+ / tvOS  9.0+
- Xcode 12 +
- Swift 5.0 +

# Installation

```ruby
pod 'DispatchCenter', '~> 1.2.0'
```

# Usage

## Register

```swift
// register your service provider
class CourseViewController: UIViewController {
	var id: Int?
}

extension CourseViewController: ServiceProviderProtocol {
	static func create(_ arguments: [String: Any]? = nil) -> Self {
		let courseVC = CourseViewController.init(nibName: "CourseViewController", bundle: nil) as! Self
		return courseVC
	}
}

// register process with Type
let container = ServiceManager()
// without parameter
container.register(CourseViewController.self) { (_) -> CourseViewController in
            let course = CourseViewController.create()
            return course
        }

// with parameter
container.register(CourseViewController.self) { (_, id: Int) -> CourseViewController in
            let course = CourseViewController.create(["id": id])
            return course
        }

```

## Resolve

```swift
let container = ServiceManager()
// without parameter
let course = container.resolve(CourseViewController.self)!
self.showViewController(course, from: self)

// without parameter
let course = container.resolve(CourseViewController.self)!
self.showViewController(course, from: self)
```

## Map URL to ViewController

```swift
// register process with URL
class LessonViewController: UIViewController {
    
    var id: Int?

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

// url with query parameters
let url= "dispatch://course/lesson"
container.register(url: url) { (_, parameter: [String: String]?) -> LessonViewController in
            var arguments: [String: Any] = [:]
            if let idstr = parameter?["id"], let id = Int(idstr) {
                arguments["id"] = id
            }
            let course = LessonViewController.create(arguments)
            return 
        }

let resolveURL = "dispatch://course/lesson?id=1"
let lesson = container.openURL(url: resolveURL)
self.showViewController(lesson, sender: nil)
```

## Navigator

DispatchCenter support navigate through conform NavigatorType protocol。see below code

```swift
// define a RouteManager and confirm NavigatorType protocol
// register url
// navigate with url

let url= "dispatch://course/lesson"

final class RouteManager: NavigatorType {
    
    static let `default` = RouteManager()

    private let container = ServiceManager()
    
    private init() {}
    
    func register() -> Void {
        container.register(url: url) { (_, params) -> DepViewController in
            let lesson = LessonViewController.create(params)
            return lesson
        }
    }
}

extension RouteManager {
    func presentController() -> Void {
        let url = "dispatch://course/lesson?id=1"
        self.presentURL(url, controllerType: LessonViewController.self, container: container, animated: true)
    }
}

```

more usage in [Example](https://github.com/OnePieceLv/DispatchCenter/tree/main/Example/DispatchCenter-iOSDemo) and [test case](https://github.com/OnePieceLv/DispatchCenter/tree/main/DispatchCenterTests)

# Want to contribute?

IF you want to contribute, [the Contributing guide is the best place to start](https://github.com/OnePieceLv/DispatchCenter/blob/main/CONTRIBUTING.md). If you have questions, feel free to ask.

# License

DispatchCenter is released under the MIT license. See [LICENSE](https://github.com/OnePieceLv/DispatchCenter/blob/main/LICENSE) for details.
