//
//  ViewController.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 1
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.register(ListingsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        flowLayout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = .gray
        return collectionView
    }()
    
    var listings: [[Listing]]! {
        didSet {
            pageControl.numberOfPages = listings?.count ?? 0
            collectionView.reloadData()
        }
    }
    
    var forecast: Forecast? {
        didSet {
            if forecast != nil {
                listings = sort(listings: forecast!.list)
                setupNavigation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigation()
        fetchForecast()
        setupViews()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        layout.itemSize = collectionView.bounds.size
        collectionView.register(ListingsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = ThemeManager.themeBackground
    }
    
    func setupViews() {
        
        view.backgroundColor = ThemeManager.themeBackground
        view.addSubview(pageControl)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            pageControl.heightAnchor.constraint(equalToConstant: 40),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor)
            ])
    }
    
    private func setupNavigation() {
        title = forecast?.city.name.uppercased()
        if let dateString = forecast?.list.first?.toDateString(format: .fullDate) {
            navigationItem.prompt = dateString
        }
    }
    
    func refreshForecast() {
        self.fetchForecast()
    }
    
    private func fetchForecast() {
        
        let FORECAST_URL = EndpointManager.Endpoint.FORECAST.rawValue
        let API_KEY = Config.apiKey
        let CITY_ID = Config.cityId
        
        APIManager.fetch(urlString: FORECAST_URL,
                         apiKey: API_KEY,
                         cityId: CITY_ID,
                         completion: { (forecast, error) in
                            guard let forecast = forecast else { return }
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
    
    func didScrollToIndex(index: Int) {
        pageControl.currentPage = index
    }
    
    func updateNavigationDate(text: String) {
        navigationItem.prompt = text
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ListingsCollectionViewCell
        cell.listings = self.listings[indexPath.item]
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        let index = Int(contentOffsetX / collectionView.bounds.size.width)
        didScrollToIndex(index: index)
        if let dateString = self.listings[index].first?.toDateString(format: .fullDate) {
            updateNavigationDate(text: dateString)
        }
    }
}
