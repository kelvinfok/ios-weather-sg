//
//  ViewController.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // https://dribbble.com/shots/3735400-Weather-App
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.isPagingEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let numberOfListingsPerDay = 8
    private let numberOfDaysPerQuery = 5
    
    var listings: [[Listing]]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var forecast: Forecast? {
        didSet {
            listings = sort(listings: forecast!.list)
            setupNavigation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        fetchForecast()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func setupNavigation() {
        title = forecast?.city.name
    }
    
    private func fetchForecast() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?id=1880252&appid=1266f20628258429083a478eac387165")!
        APIManager.fetch(url: url, completion: { (forecast, error) in
            DispatchQueue.main.async {
                self.forecast = forecast
            }
        })
    }
    
    func getLocalDate(listing: Listing) -> Date {
        let dt = listing.dt
        return Date(timeIntervalSince1970: dt).toLocalTime()
    }
    
    func sort(listings: [Listing]) -> [[Listing]] {
        
        var masterListings = [[Listing]]()
        var tempListings = [Listing]()
        
        for listing in listings {
            let dateString = listing.dt.getDateStringFromUnixTime(dateStyle: .long, timeStyle: .none).components(separatedBy: ",").first!
            if tempListings.isEmpty {
                tempListings.append(listing)
            } else {
                if let lastItem = tempListings.last, let lastDateString = lastItem.dt.getDateStringFromUnixTime(dateStyle: .long, timeStyle: .none).components(separatedBy: ",").first {
                    if dateString.elementsEqual(lastDateString) {
                        tempListings.append(listing)
                    } else {
                        masterListings.append(tempListings)
                        tempListings.removeAll()
                        tempListings.append(listing)
                    }
                } else {
                    tempListings.append(listing)
                }
            }
        }
        
        return masterListings
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MainTableViewCell
        cell.listings = self.listings?[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height
    }
    
}
