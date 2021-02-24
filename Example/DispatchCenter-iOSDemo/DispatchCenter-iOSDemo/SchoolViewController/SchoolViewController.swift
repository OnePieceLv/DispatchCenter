//
//  SchoolViewController.swift
//  DispatchCenter-iOSDemo
//
//  Created by steven on 2021/2/22.
//

import UIKit

class SchoolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "学校"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseCourse(_ sender: UIButton) {
        let navigator = RouteManager.default
        let course = navigator.container.resolve(CourseViewController.self)!
        navigator.presentViewController(course, animated: true) {
            print("presented")
        }
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
