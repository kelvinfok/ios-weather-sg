//
//  ListDetailCollectionViewCell.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class ListDetailCollectionViewCell: UICollectionViewCell {
    
    let randomColor = UIColor.random
    
    lazy var arrowRightImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "icArrowRight"))
        let newImage = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.image = newImage
        imageView.tintColor = getComplementaryForColor(color: randomColor)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var arrowDownImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "icArrowDown"))
        let newImage = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.image = newImage
        imageView.tintColor = getComplementaryForColor(color: randomColor)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = randomColor
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
        label.textColor = ThemeManager.themeBackground
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
        label.textColor = ThemeManager.themeBackground
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
    
    var listing: Listing! {
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
        backgroundColor = ThemeManager.themeBackground
        addSubview(containerView)
        addSubview(timeLabel)
        addSubview(arrowRightImageView)
        addSubview(arrowDownImageView)
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
            
            timeLabel.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -16),
            timeLabel.heightAnchor.constraint(equalToConstant: 44),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            arrowRightImageView.heightAnchor.constraint(equalToConstant: 40),
            arrowRightImageView.widthAnchor.constraint(equalToConstant: 40),
            arrowRightImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            arrowRightImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            arrowDownImageView.heightAnchor.constraint(equalToConstant: 40),
            arrowDownImageView.widthAnchor.constraint(equalToConstant: 40),
            arrowDownImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            arrowDownImageView.centerXAnchor.constraint(equalTo: centerXAnchor)

            
            // descriptionLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4),
            // temperatureLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6)
            ])
        
        
        
    }
    
    func updateViews() {
        temperatureLabel.text = listing.main.getDCTemperature()
        
        
        let dayString = getDateString(date: listing.date, withFormat: "EEEE")
        
        
        descriptionLabel.text = "\n\(dayString).\nIt's sunny."
        
        timeLabel.text = getDateString(date: listing.date, withFormat: "h:mm a")
        
        
    }
    
    func getComplementaryForColor(color: UIColor) -> UIColor {
        let ciColor = CIColor(color: color)
        let compRed: CGFloat = 1.0 - ciColor.red
        let compGreen: CGFloat = 1.0 - ciColor.green
        let compBlue: CGFloat = 1.0 - ciColor.blue
        return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
    }
    
    func getDateString(date: Date, withFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcDateString = formatter.string(from: date)
        let newDate = formatter.date(from: utcDateString)
        formatter.dateFormat = format
        return formatter.string(from: newDate!)
    }
    
    
    
}
