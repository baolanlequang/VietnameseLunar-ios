//
//  ViewController.swift
//  TestCalendar
//
//  Created by Lan Le on 14.02.22.
//

import UIKit
import VietnameseLunar

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let vietnameseCalendar = VietnameseCalendar(date: Date.now)
        let vietnameseDate = vietnameseCalendar.vietnameseDate
        print("\(vietnameseDate?.toString())")
    }


}

