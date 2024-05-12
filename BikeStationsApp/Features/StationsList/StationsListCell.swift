//
//  StationsListCell.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit

final class StationsListCell: UITableViewCell {
    
    private let stationView = StationView()
    
    private enum Constants {
        static let stationViewTopAnchorConstant: CGFloat = 8
        static let stationViewTrailingAnchorConstant: CGFloat = -16
        static let stationViewBottomAnchorConstant: CGFloat = -8
        static let stationViewLeadingAnchorConstant: CGFloat = 16
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with station: Station) {
        stationView.load(StationViewViewModel(station: station))
    }
    
    private func addSubviews() {
        contentView.addSubview(stationView)
    }
    
    private func setupSubviews() {
        selectionStyle = .none
        contentView.backgroundColor = .background
        
        stationView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stationView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.stationViewTopAnchorConstant),
            stationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.stationViewTrailingAnchorConstant),
            stationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.stationViewBottomAnchorConstant),
            stationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.stationViewLeadingAnchorConstant)
        ])
    }
}
