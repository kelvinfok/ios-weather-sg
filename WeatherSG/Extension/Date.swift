//
//  Date.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

extension Date {
    
    enum Format: String {
        case time = "h:mm a"
        case day = "EEEE"
        case dateTime = "MMM d, h:mm a"
        case fullDate = "EEEE, MMM d, yyyy"
    }
    
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    static func toString(format: Format, dt: Double) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = Date(timeIntervalSince1970: dt)
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.string(from: dt)
    }
}
