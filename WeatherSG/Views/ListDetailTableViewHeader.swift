//
//  ListDetailTableViewHeader.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 6/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class ListDetailHeaderView: UITableViewHeaderFooterView {
    
    var listing: Listing! {
        didSet {
            updateViews()
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ThemeManager.themeFontBold, size: 36)
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.lineBreakMode = .byClipping
        label.numberOfLines = 0
        label.textColor = ThemeManager.themeBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ThemeManager.themeFontBold, size: 24)
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
        let view = UIStackView(arrangedSubviews: [temperatureLabel, descriptionLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        contentView.backgroundColor = ThemeManager.themeBackground
        
        addSubview(imageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 108),
            imageView.heightAnchor.constraint(equalToConstant: 108),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
            ])
    }
    
    func updateViews() {
        temperatureLabel.text = listing.main.temp.rounded(toDecimalPlaces: 1).toString().appending("°")
        if let id = listing.weather.first?.id {
            imageView.image = getWeatherIcon(id: id)
        }
        descriptionLabel.text = listing.weather.first?.description
    }
    
    func getWeatherIcon(id: Int) -> UIImage {
        switch id {
        case 0...300 :
            return UIImage(named: "icStorm")!
        case 301...500 :
            return UIImage(named: "icLightRain")!
        case 501...600 :
            return UIImage(named: "icShower")!
        case 601...700 :
            return UIImage(named: "icSnow")!
        case 701...771 :
            return UIImage(named: "icFog")!
        case 772...799 :
            return UIImage(named: "icStorm2")!
        case 800 :
            return UIImage(named: "icSunny")!
        case 801...804 :
            return UIImage(named: "icCloudy")!
        case 900...903, 905...1000  :
            return UIImage(named: "icStorm2")!
        case 903 :
            return UIImage(named: "icSnow2")!
        case 904 :
            return UIImage(named: "icSunny")!
        default :
            return UIImage(named: "icDefault")!
        }
    }
}
