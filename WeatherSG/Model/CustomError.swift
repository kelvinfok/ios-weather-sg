//
//  CustomError.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import Foundation

public enum CustomError: Error {
    case noDataFound
}

extension CustomError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .noDataFound:
            return "Something went wrong. Please try again later."
        }
    }
}
