//
//  ViewController.swift
//  DemoVietnameseLunar
//
//  Created by Lan Le on 15.02.22.
//

import UIKit
import VietnameseLunar

class ViewController: UIViewController {

    @IBOutlet weak var lblVietnameseDay: UILabel!
    @IBOutlet weak var lblToday: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let today = Date()
        let strToday = dateFormatter.string(from: today)
        self.lblToday.text = strToday
        
        //display Vietnamese day
        let vietnameseCalendar = VietnameseCalendar(date: today)
        let strVietnameseDay = vietnameseCalendar.vietnameseDate.toString()
        self.lblVietnameseDay.text = strVietnameseDay
    }


}

