//
//  Date.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

extension Date {
    
    func isSameDay(date: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: self, to: date)
        if diff.day == 0 {
            print("same day")
            return true
        } else {
            print("different day")
            return false
        }
    }
    
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
