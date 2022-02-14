//
//  VietnameseCalendar.swift
//  VietnameseLunar
//
//  Created by Lan Le on 14.02.22.
//

import Foundation

public class VietnameseCalendar {
    private var solarDate: Date!
    private var solarCalendar: Calendar!
    
    public class VietnameseDate {
        public var day = ""
        public var month = ""
        public var year = ""
        public var can = ""
        public var chi = ""
        
        init(day: String, month: String, year: String, can: String, chi: String) {
            self.day = day
            self.month = month
            self.year = year
            self.can = can
            self.chi = chi
        }
        
        public func toString() -> String {
            return "Ngày \(self.day), tháng \(self.month), năm \(can) \(chi)"
        }
    }
    
    public var vietnameseDate: VietnameseDate!
    
    public init(date: Date) {
        self.solarDate = date
        self.solarCalendar = Calendar(identifier: .gregorian)
        self.getVietnameseDate()
        
    }
    
    private func getVietnameseDate() {
        let lunarDate = self.convertSolar2LunarDate()
        
        let lunarCalendar = Calendar(identifier: .gregorian)
        let components: Set = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day]
        let lunarComps = lunarCalendar.dateComponents(components, from: lunarDate)
        
        
        let day = lunarComps.day ?? 0
        let month = lunarComps.month ?? 0
        let year = lunarComps.year ?? 0
        let modLunar = year % 12
        
        var chiStr = ""
        switch (modLunar) {
        case ConGiap.TI.rawValue:
            chiStr = "Tý"
        case ConGiap.SUU.rawValue:
            chiStr = "Sửu"
        case ConGiap.DAN.rawValue:
            chiStr = "Dần"
        case ConGiap.MAO.rawValue:
            chiStr = "Mão"
        case ConGiap.THIN.rawValue:
            chiStr = "Thìn"
        case ConGiap.TY.rawValue:
            chiStr = "Tỵ"
        case ConGiap.NGO.rawValue:
            chiStr = "Ngọ"
        case ConGiap.MUI.rawValue:
            chiStr = "Mùi"
        case ConGiap.THAN.rawValue:
            chiStr = "Thân"
        case ConGiap.DAU.rawValue:
            chiStr = "Dậu"
        case ConGiap.TUAT.rawValue:
            chiStr = "Tuất"
        case ConGiap.HOI.rawValue:
            chiStr = "Hợi"
        default:
            break
        }
        
        let modCan = year % 10
        var canStr = ""
        switch (modCan) {
        case MuoiCan.CANH.rawValue:
            canStr = "Canh"
        case MuoiCan.TAN.rawValue:
            canStr = "Tân"
        case MuoiCan.NHAM.rawValue:
            canStr = "Nhâm"
        case MuoiCan.QUY.rawValue:
            canStr = "Quý"
        case MuoiCan.GIAP.rawValue:
            canStr = "Giáp"
        case MuoiCan.AT.rawValue:
            canStr = "Ất"
        case MuoiCan.BINH.rawValue:
            canStr = "Bính"
        case MuoiCan.DINH.rawValue:
            canStr = "Đinh"
        case MuoiCan.MAU.rawValue:
            canStr = "Mậu"
        case MuoiCan.KY.rawValue:
            canStr = "Kỷ"
        default:
            break
        }
        
        self.vietnameseDate = VietnameseDate(day: "\(day)", month: "\(month)", year: "\(year)", can: canStr, chi: chiStr)
    }
    
    private func convertSolar2LunarDate() -> Date {
        let timeZone = 7
        let dayNumber = self.jdFromDate(date: self.solarDate)
        let k = Int(floor(((Double(dayNumber) - 2415021.076998695) / 29.530588853)))
        var monthStart = self.getNewMoonDay(k: k+1, timeZone: timeZone)
        if (monthStart > dayNumber) {
            monthStart = self.getNewMoonDay(k: k, timeZone: timeZone)
        }
        
        let components: Set = [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day]
        let comps = self.solarCalendar.dateComponents(components, from: self.solarDate)
        let solarYear = comps.year ?? 0
        var lunarYear = 0
        
        var a11 = self.getLunarMonth11(year: solarYear, timeZone: timeZone)
        var b11 = a11
        if (a11 >= monthStart) {
            lunarYear = solarYear
            a11 = self.getLunarMonth11(year: solarYear-1, timeZone: timeZone)
        } else {
            lunarYear = solarYear+1
            b11 = self.getLunarMonth11(year: solarYear+1, timeZone: timeZone)
        }
        let lunarDay = dayNumber-monthStart+1
        let diff = Int(floor(((Double(monthStart) - Double(a11))/29)))
        var lunarLeap = false
        var lunarMonth = diff+11
        if (b11 - a11 > 365) {
            let leapMonthDiff = self.getLeapMonthOffset(a11: a11, timeZone: timeZone)
            if (diff >= leapMonthDiff) {
                lunarMonth = diff + 10
                if (diff == leapMonthDiff) {
                    lunarLeap = true
                }
            }
        }
        if (lunarMonth > 12) {
            lunarMonth = lunarMonth - 12;
        }
        if (lunarMonth >= 11 && diff < 4) {
            lunarYear -= 1;
        }
        
        var lunarComps = DateComponents()
        lunarComps.year = lunarYear
        lunarComps.month = lunarMonth
        lunarComps.day = lunarDay
        
        let result = self.solarCalendar.date(from: lunarComps) ?? Date.now
        return result
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
    
    private func getSunLongitude(jdn: Int, timeZone: Int) -> Int {
        let T: Double = (Double(jdn) - 2451545.5 - Double(timeZone/24)) / 36525 // Time in Julian centuries from 2000-01-01 12:00:00 GMT
        let T2 = T*T
        let dr = Double.pi/180.0 // degree to radian
        let M: Double = 357.52910 + 35999.05030*T - 0.0001559*T2 - 0.00000048*T*T2 // mean anomaly, degree
        let L0 = 280.46645 + 36000.76983*T + 0.0003032*T2 // mean longitude, degree
        var DL = (1.914600 - 0.004817*T - 0.000014*T2)*sin(dr*M)
        DL = DL + (0.019993 - 0.000101*T)*sin(dr*2*M) + 0.000290*sin(dr*3*M);
        var L = L0 + DL // true longitude, degree
        L = L*dr
        L = L - Double.pi*2*((L/(Double.pi*2))) // Normalize to (0, 2*PI)
        return Int(floor((L / Double.pi * 6)))
    }
    
    private func getLunarMonth11(year: Int, timeZone: Int) -> Int {
        var comps = DateComponents()
        comps.day = 31
        comps.month = 12
        comps.year = year
        let date = self.solarCalendar.date(from: comps) ?? Date.now
        
        let off = self.jdFromDate(date: date) - 2415021
        let k = Int(floor((Double(off) / 29.530588853)))
        var nm = self.getNewMoonDay(k: k, timeZone: timeZone)
        let sunLong = self.getSunLongitude(jdn: nm, timeZone: timeZone) // sun longitude at local midnight
        if (sunLong >= 9) {
            nm = self.getNewMoonDay(k: k-1, timeZone: timeZone)
        }
        return nm
    }
    
    private func getLeapMonthOffset(a11: Int, timeZone: Int) -> Int {
        let k = Int(floor(((Double(a11) - 2415021.076998695) / 29.530588853 + 0.5)))
        var last = 0
        var i = 1 // We start with the month following lunar month 11
        var arc = self.getSunLongitude(jdn: self.getNewMoonDay(k: k+1, timeZone: timeZone), timeZone: timeZone)
        repeat {
            last = arc
            i += 1
            arc = self.getSunLongitude(jdn: self.getNewMoonDay(k: k+i, timeZone: timeZone), timeZone: timeZone)
        } while (arc != last && i < 14)
        return i-1;
    }

}
