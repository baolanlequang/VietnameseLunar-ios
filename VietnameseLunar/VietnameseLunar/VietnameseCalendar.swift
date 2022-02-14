//
//  VietnameseCalendar.swift
//  VietnameseLunar
//
//  Created by Lan Le on 14.02.22.
//

import Foundation

class VietnameseCalendar {
    var solarDate: Date!
    var solarCalendar: Calendar!
    
    init() {}
    
    init(date: Date) {
        self.solarDate = date
        self.solarCalendar = Calendar(identifier: .gregorian)
    }
    
    func convertSolar2LunarDate() -> Date {
    }
    
    private func jdFromDate(date: Date) -> Int {
        let components: Set = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day]
        let calendarComps = self.solarCalendar.dateComponents(components, from: date)
        let day = calendarComps.day ?? 0
        let month = calendarComps.month ?? 0
        let year = calendarComps.year ?? 0
        
        let a = Int(floor(Double(((14 - month)/12))))
        let y = year + 4800 - a
        let m = month + 12*a - 3
        
        var jd = Int(day + (153*m+2)/5 + 365*y + y/4 - y/100 + y/400 - 32045)
        if (jd < 2299161) {
            jd = Int(day + (153*m+2)/5 + 365*y + y/4 - 32083)
        }
        return jd
    }
    
    private func getNewMoonDay(k: Int, timeZone: Int) -> Int {
        let T: Double = Double(k)/1236.85 // Time in Julian centuries from 1900 January 0.5
        let T2: Double = T * T
        let T3: Double = T2 * T
        let dr: Double = Double.pi/180.0
        let expres1: Double = 29.53058868*Double(k)
        var Jd1: Double = 2415020.75933 + expres1 + 0.0001178*T2 - 0.000000155*T3
        Jd1 = Jd1 + 0.00033*sin((166.56 + 132.87*T - 0.009173*T2)*dr) // Mean new moon
        let M: Double = 359.2242 + 29.10535608*Double(k) - 0.0000333*T2 - 0.00000347*T3 // Sun's mean anomaly
        let Mpr: Double = 306.0253 + 385.81691806*Double(k) + 0.0107306*T2 + 0.00001236*T3 // Moon's mean anomaly
        let F = 21.2964 + 390.67050646*Double(k) - 0.0016528*T2 - 0.00000239*T3 // Moon's argument of latitude
        
        var C1: Double = (0.1734 - 0.000393*T)*sin(M*dr) + 0.0021*sin(2*dr*M)
        C1 = C1 - 0.4068*sin(Mpr*dr) + 0.0161*sin(dr*2*Mpr)
        C1 = C1 - 0.0004*sin(dr*3*Mpr)
        C1 = C1 + 0.0104*sin(dr*2*F) - 0.0051*sin(dr*(M+Mpr))
        C1 = C1 - 0.0074*sin(dr*(M-Mpr)) + 0.0004*sin(dr*(2*F+M))
        C1 = C1 - 0.0004*sin(dr*(2*F-M)) - 0.0006*sin(dr*(2*F+Mpr))
        C1 = C1 + 0.0010*sin(dr*(2*F-Mpr)) + 0.0005*sin(dr*(2*Mpr+M))
        var deltat: Double = 0.0
        if (T < -11) {
            deltat = 0.001 + 0.000839*T + 0.0002261*T2 - 0.00000845*T3 - 0.000000081*T*T3
        } else {
            deltat = -0.000278 + 0.000265*T + 0.000262*T2
        }
        let JdNew = Jd1 + C1 - deltat;
        return Int(floor((JdNew + 0.5 + Double(timeZone)/24.0)))
    }
}
