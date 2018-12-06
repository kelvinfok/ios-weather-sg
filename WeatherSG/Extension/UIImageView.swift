//
//  UIImageView.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 6/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

extension UIImageView {
    
        func loadFromURL(urlString: String){
            let url = URL(string: urlString)!
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, res, error) in
                if error != nil {
                    print(error!)
                }
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            task.resume()
    }
}
