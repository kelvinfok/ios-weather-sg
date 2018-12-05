//
//  Double.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 5/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import Foundation

extension Double {
    
    
    func getDateStringFromUnixTime(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
