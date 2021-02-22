//
//  CourseViewController.swift
//  DispatchCenter-iOSDemo
//
//  Created by steven on 2021/2/22.
//

import UIKit

class CourseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "课程"
        // Do any additional setup after loading the view.
    }
    @IBAction func openLesson(_ sender: UIButton) {
//        let lesson = container.openURL(url: url, serviceType: LessonViewController.self)!
//        navigator.showViewController(lesson)
//        navigator.showURL(url, controllerType: LessonViewController.self, container: container)
//        navigator.presentURL(url, controllerType: LessonViewController.self, container: container, animated: true) {
//            print("present to lesson with url")
//        }
        navigator.pushURL(url, controllerType: LessonViewController.self, container: container, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

