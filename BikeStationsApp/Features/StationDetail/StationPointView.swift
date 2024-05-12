//
//  StationPointView.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit
import MapKit

class StationPointView: BaseView {
    
    private let numberBikesAvailableLabel = UILabel()
    private let bikeImageView = UIImageView()
    private let stackView = UIStackView()
    
    private enum Constants {
        static let stackViewTopAnchorConstant: CGFloat = 4
        static let stackViewTrailingAnchorConstant: CGFloat = -6
        static let stackViewBottomAnchorConstant: CGFloat = -4
        static let stackViewLeadingAnchorConstant: CGFloat = 5
        static let bikeImageViewHeight: CGFloat = 16
        static let bikeImageViewWidth: CGFloat = bikeImageViewHeight
        static let numberBikesAvailableLabelFontSize: CGFloat = 18
    }
        
    private let numberBikesAvailable: Int

    init(numberBikesAvailable: Int) {
        self.numberBikesAvailable = numberBikesAvailable
        super.init()
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(stackView)
        
        [numberBikesAvailableLabel, bikeImageView].forEach(stackView.addArrangedSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        backgroundColor = .white
        
        [stackView,
         numberBikesAvailableLabel,
         bikeImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        bikeImageView.image = .bike
        
        numberBikesAvailableLabel.text = String(numberBikesAvailable)
        numberBikesAvailableLabel.font = UIFont(name: Fonts.manropeBold, size: Constants.numberBikesAvailableLabelFontSize)
        numberBikesAvailableLabel.textColor = .text
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.stackViewTopAnchorConstant),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.stackViewTrailingAnchorConstant),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.stackViewBottomAnchorConstant),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.stackViewLeadingAnchorConstant),

            bikeImageView.widthAnchor.constraint(equalToConstant: Constants.bikeImageViewWidth),
            bikeImageView.heightAnchor.constraint(equalToConstant: Constants.bikeImageViewHeight)
        ])
    }
}
