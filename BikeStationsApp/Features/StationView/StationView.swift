//
//  StationView.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit

class StationView: BaseView {
    
    private let titleLabel = UILabel()
    private let addressLabel = UILabel()
    private let stackView = UIStackView()
    private let bikesView = StationStatusView(type: .bikes)
    private var placesView = StationStatusView(type: .places)
    
    func setup(id: String,
               address: String,
               name: String,
               numberBikesAvailable: Int,
               numberDocksAvailable: Int) {
        titleLabel.text = "\(id) \(address)"
        addressLabel.text = "500m • \(name)"
        
        bikesView.number = numberBikesAvailable
        placesView.number = numberDocksAvailable
    }
        
    override func addSubviews() {
        super.addSubviews()
        [titleLabel,
         addressLabel,
         stackView].forEach(addSubview)
        
        [bikesView, placesView].forEach(stackView.addArrangedSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        [titleLabel,
         addressLabel,
         bikesView,
         placesView,
         stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        addressLabel.font = .systemFont(ofSize: 12)
        
        stackView.distribution = .fillProportionally
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            addressLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
