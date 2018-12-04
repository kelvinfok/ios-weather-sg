//
//  ListDetailCollectionViewCell.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class ListDetailCollectionViewCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.random
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 500, weight: .bold)
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [descriptionLabel, temperatureLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    var listing: Listing? {
        didSet {
            updateViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.setCircular()
    }
    
    func setupViews() {
        backgroundColor = UIColor.lightGray

        addSubview(containerView)
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.9),
            stackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            descriptionLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4),
            temperatureLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6)
            ])
        
        
        
    }
    
    func updateViews() {
        temperatureLabel.text = listing?.main.getDCTemperature()
        
        if let date = listing?.dt {
            let day = Date(timeIntervalSince1970: date).toLocalTime().getDay()
            descriptionLabel.text = "\n\(day).\nIt's sunny."

        }
        
        
    }
    
    
    
}
