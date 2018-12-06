//
//  APIManager.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import Foundation

struct APIManager {
        
    static func fetch(urlString: String, apiKey: String, cityId: String, completion: @escaping (Forecast?, Error?) -> Void) {
        
        let params: [String : String] = ["id": cityId, "appid": apiKey, "units" : "metric"]
        
        let queryString = buildQueryString(fromDictionary: params)
        
        let combined = urlString + queryString
        print("combined: \(combined)")
        
        let url = URL(string: urlString.appending(queryString))!
        
        let request = URLRequest(url: url)

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = CustomError.noDataFound
                completion(nil, error)
                return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let forecast = try decoder.decode(Forecast.self, from: data)
                completion(forecast, nil)
            } catch(let error) {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    static func buildQueryString(fromDictionary parameters: [String: String]) -> String {
        
        var urlVars: [String] = []
        
        for (k, value) in parameters {
            if let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                urlVars.append(k + "=" + encodedValue)
            }
        }
        
        return urlVars.isEmpty ? "" : "?" + urlVars.joined(separator: "&")
    }
}
