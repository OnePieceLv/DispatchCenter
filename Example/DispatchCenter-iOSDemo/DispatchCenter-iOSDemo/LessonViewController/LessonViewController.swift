//
//  LessonViewController.swift
//  DispatchCenter-iOSDemo
//
//  Created by steven on 2021/2/23.
//

import UIKit

class LessonViewController: UIViewController {
    
    var id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = id else {
            return
        }
        self.navigationItem.title = "课程ID: \(id)"
        // Do any additional setup after loading the view.
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
