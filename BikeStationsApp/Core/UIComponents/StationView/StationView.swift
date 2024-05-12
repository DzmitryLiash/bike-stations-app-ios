//
//  StationView.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit

final class StationView: BaseView {
        
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let stackView = UIStackView()
    private let bikesView = StationStatusView(type: .bikes)
    private let placesView = StationStatusView(type: .places)
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let titleLabelFontSize: CGFloat = 24
        static let subtitleLabelFontSize: CGFloat = 12
        static let titleLabelTopAnchorConstant: CGFloat = 16
        static let titleLabelTrailingAnchorConstant: CGFloat = -16
        static let titleLabelLeadingAnchorConstant: CGFloat = 16
        static let subtitleLabelTopAnchorConstant: CGFloat = 6
        static let stackViewTopAnchorConstant: CGFloat = 12
        static let stackViewBottomAnchorConstant: CGFloat = -16
    }
    
    func load(_ viewModel: StationViewViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.attributedText = getAttributedSubtitleText(with: viewModel.distance, viewModel.address)
        bikesView.numberLabelText = viewModel.bikesAvailableCount
        placesView.numberLabelText = viewModel.docksAvailableCount
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        [titleLabel,
         subtitleLabel,
         stackView].forEach(addSubview)
        
        [bikesView, placesView].forEach(stackView.addArrangedSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = .white
        
        [titleLabel,
         subtitleLabel,
         bikesView,
         placesView,
         stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.font = UIFont(name: AppFont.manropeBold, size: Constants.titleLabelFontSize)
        titleLabel.textColor = .text
        
        subtitleLabel.textColor = .text
        
        stackView.distribution = .fillProportionally
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleLabelTopAnchorConstant),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.titleLabelTrailingAnchorConstant),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLabelLeadingAnchorConstant),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.subtitleLabelTopAnchorConstant),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.stackViewTopAnchorConstant),
            stackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: Constants.stackViewBottomAnchorConstant)
        ])
    }
    
    private func getAttributedSubtitleText(with distance: String, _ address: String) -> NSMutableAttributedString {
        let distanceAttributedString = NSMutableAttributedString(string: distance)
        let address = distance.isEmpty ? address : " • \(address)"
        let addressAttributedString = NSMutableAttributedString(string: address)
        
        distanceAttributedString.addAttribute(.font,
                                              value: UIFont(name: AppFont.manropeBold,
                                                            size: Constants.subtitleLabelFontSize) ?? UIFont.boldSystemFont(ofSize: Constants.subtitleLabelFontSize),
                                              range: NSRange(location: 0, length: distance.count))
        addressAttributedString.addAttribute(.font,
                                             value: UIFont(name: AppFont.manropeMedium, size: Constants.subtitleLabelFontSize) ?? UIFont.systemFont(ofSize: Constants.subtitleLabelFontSize, weight: .medium),
                                             range: NSRange(location: 0, length: address.count))
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(distanceAttributedString)
        combinedAttributedString.append(addressAttributedString)
        
        return combinedAttributedString
    }
}
