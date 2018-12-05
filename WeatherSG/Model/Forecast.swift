//
//  Forecast.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import Foundation

class Forecast: Codable {
    
    let cod: String
    let message: Double
    let cnt: Int
    let list: [Listing]
    let city: City
}

class Listing: Codable {
    
    // Kelvin to celsius 0:-273.15
    
    let dt: Double
    let weather: [WeatherDetail]
    let main: Main
    let dtTxt: String
    
    var date: Date! {        
        let _date = Date(timeIntervalSince1970: dt)
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: _date))
        return Date(timeInterval: seconds, since: _date)
    }
    
    class WeatherDetail: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    class Main: Codable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
        
        func getDCTemperature() -> String {
            return String(format: "%.0f", temp - 273.15)
        }
    }
    
}

class City: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
}

class Coordinate: Codable {
    let lat: Double
    let lon: Double
}

