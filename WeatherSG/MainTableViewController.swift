//
//  ViewController.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    // https://dribbble.com/shots/3735400-Weather-App
    
    var forecast: Forecast? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchForecast()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.isPagingEnabled = true
    }
    
    private func fetchForecast() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=1880252&appid=1266f20628258429083a478eac387165")!
        APIManager.fetch(url: url, completion: { (forecast, error) in
            DispatchQueue.main.async {
                self.forecast = forecast
            }
        })
    }
}

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (forecast?.list.count ?? 0) / 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .random
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height
    }
    
    
}

