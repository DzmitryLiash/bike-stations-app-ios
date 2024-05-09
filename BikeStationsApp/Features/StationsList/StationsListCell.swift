//
//  StationsListCell.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit

final class StationsListCell: UITableViewCell {
    
    private let stationView = StationView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(id: String,
               address: String,
               name: String,
               numberBikesAvailable: Int,
               numberDocksAvailable: Int) {
        stationView.setup(id: id,
                          address: address,
                          name: name,
                          numberBikesAvailable: numberBikesAvailable,
                          numberDocksAvailable: numberDocksAvailable)
    }
    
    private func addSubviews() {
        contentView.addSubview(stationView)
    }
    
    private func setupSubviews() {
        selectionStyle = .none
        contentView.backgroundColor = .background
        
        stationView.translatesAutoresizingMaskIntoConstraints = false
        stationView.layer.cornerRadius = 16
        stationView.backgroundColor = .white
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stationView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
