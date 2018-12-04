//
//  UIView.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 5/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

extension UIView {
    
    func setCornerRadius(value: CGFloat) {
        layer.cornerRadius = value
        layer.masksToBounds = true
    }
    
    func setCircular() {
        let value = min(frame.height, frame.width) / 2
        setCornerRadius(value: value)
    }
    
    
    
}

