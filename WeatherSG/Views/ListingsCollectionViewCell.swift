//
//  ListDetailCollectionViewCell.swift
//  WeatherSG
//
//  Created by Kelvin Fok on 4/12/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class ListingsCollectionViewCell: UICollectionViewCell {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ListDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.tableFooterView = UIView()
        tableView.isPagingEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ThemeManager.themeBackground
        return tableView
    }()
    
    var listings: [Listing]? {
        didSet {
            tableView.reloadData()
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
    
    func setupViews() {
        
        backgroundColor = ThemeManager.themeBackground
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

extension ListingsCollectionViewCell: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ListingTableViewCell
        cell.listing = self.listings![indexPath.item]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! ListDetailHeaderView
        view.listing = self.listings!.first
        return view
    }
}
