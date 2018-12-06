//
//  MainTableViewCell.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ThemeManager.themeFontMedium, size: 16)
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textColor = ThemeManager.themeBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textAlignment = .center
        return label
    }()

    
    lazy var temperatureMinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ThemeManager.themeFontMedium, size: 16)
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textAlignment = .center
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ThemeManager.themeFontMedium, size: 16)
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textColor = ThemeManager.themeBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textAlignment = .left
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, temperatureLabel, temperatureMinLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var listing: Listing! {
        didSet {
            updateViews()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        
        backgroundColor = ThemeManager.themeBackground
        
        addSubview(containerView)
        
        containerView.addSubview(timeLabel)
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            timeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeLabel.heightAnchor.constraint(equalToConstant: 32),
            timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            temperatureMinLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureMinLabel.heightAnchor.constraint(equalToConstant: 32),
            ])
    }
    
    func updateViews() {
        timeLabel.text = listing.dateString
        temperatureLabel.text = listing.main.temp.rounded(toDecimalPlaces: 1).toString().appending("°")
        temperatureMinLabel.text = listing.main.tempMin.rounded(toDecimalPlaces: 1).toString().appending("°")
        if let urlString = listing.weather.first?.iconImage {
            iconImageView.loadFromURL(urlString: urlString)
        }
    }
}
